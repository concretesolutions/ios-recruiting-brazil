import Combine
import UIKit

public final class MoviesCoordinator {
  private var cancellables = Set<AnyCancellable>()
  public let tabBarController: MainViewController
  public let navigationController: UINavigationController
  private let metadata: CurrentValueSubject<MetaData, Never>

  public init(
    tabBarController: MainViewController,
    metadata: CurrentValueSubject<MetaData, Never>
  ) {
    self.tabBarController = tabBarController
    self.metadata = metadata
    navigationController = UINavigationController()
  }

  public func start() {
    let viewController = MoviesViewController(viewModel: .default(metaData: metadata.eraseToAnyPublisher()))

    viewController.presentMovieDetails
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] movie in
        guard let self = self else { return }
        self.goToMovieDetails(movie: movie)
      })
      .store(in: &cancellables)

    navigationController.addChild(viewController)
    tabBarController.addChild(navigationController)
  }

  private func goToMovieDetails(movie: Movie) {
    let viewControler = MovieDetailsViewController(viewModel: .init(movie: movie, metadata: metadata.value))
    navigationController.pushViewController(viewControler, animated: true)
  }
}
