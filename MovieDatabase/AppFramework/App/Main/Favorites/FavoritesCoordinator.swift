import Combine
import UIKit

public final class FavoritesCoordinator {
  private var cancellables = Set<AnyCancellable>()
  public let tabBarController: MainViewController
  public let navigationController: UINavigationController
  private let metadata: CurrentValueSubject<MetaData, Never>

  private var childCoordinators = [UUID: Any]()

  public init(
    tabBarController: MainViewController,
    metadata: CurrentValueSubject<MetaData, Never>
  ) {
    self.tabBarController = tabBarController
    self.metadata = metadata
    navigationController = UINavigationController()
  }

  public func start() {
    let viewController = FavoritesViewController(viewModel: .default())

    viewController.presentMovieDetails
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] movie in
        guard let self = self else { return }
        self.goToMovieDetails(movie: movie)
      })
      .store(in: &cancellables)

    viewController.presentFilter
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] in
        guard let self = self else { return }
        self.goToFilter()
      })
      .store(in: &cancellables)

    navigationController.addChild(viewController)
    tabBarController.addChild(navigationController)
  }

  private func goToMovieDetails(movie: Movie) {
    let viewControler = MovieDetailsViewController(viewModel: .init(movie: movie, metadata: metadata.value))
    navigationController.pushViewController(viewControler, animated: true)
  }

  private func goToFilter() {
    let filterCoordinator = FilterCoordinator(
      navigationController: navigationController,
      metadata: metadata.eraseToAnyPublisher()
    )

    let uuid = UUID()
    childCoordinators[uuid] = filterCoordinator

    filterCoordinator.finished
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] _ in
        self?.childCoordinators.removeValue(forKey: uuid)
      })
      .store(in: &cancellables)

    filterCoordinator.start()
  }
}
