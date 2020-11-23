import Combine
import TheMovieDatabaseApi
import UIKit

public class AppCoordinator {
  private let window: UIWindow
  private let navigationController: UINavigationController
  private let metaDataLoader: MetaDataLoader
  private let metaData = CurrentValueSubject<MetaData, Never>(.init(configuration: nil, genres: nil))

  private var cancellables = Set<AnyCancellable>()
  private var childCoordinators = [UUID: Any]()

  public init(window: UIWindow) {
    self.window = window
    navigationController = UINavigationController()
    metaDataLoader = MetaDataLoader()
  }

  public func start() {
    let splashViewController = SplashViewController()
    window.rootViewController = splashViewController
    window.makeKeyAndVisible()

    metaDataLoader.metaData
      .subscribe(metaData)
      .store(in: &cancellables)

    metaDataLoader.metaData
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] _ in
        let cancellableToRemove = self?.cancellables.first
        self?.startMain()

        if let cancellableToRemove = cancellableToRemove {
          DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self?.cancellables.remove(cancellableToRemove)
          }
        }
      })
      .store(in: &cancellables)

    metaDataLoader.reloadMetaData()
  }

  private func startMain() {
    let mainViewController = MainViewController(metaData: metaData.eraseToAnyPublisher())
    navigationController.addChild(mainViewController)
    navigationController.modalPresentationStyle = .fullScreen
    window.rootViewController?.present(navigationController, animated: true, completion: { [weak self] in
      DispatchQueue.main.async {
        self?.window.rootViewController = self?.navigationController
      }
    })

    Publishers.Merge(
      mainViewController.moviesViewController.presentMovieDetails,
      mainViewController.favoritesViewController.presentMovieDetails
    )
    .receive(on: DispatchQueue.main)
    .sink(receiveValue: { [weak self] movie in
      guard let self = self else { return }
      let viewModel = MovieDetailsViewModel(movie: movie, metadata: self.metaData.value)
      let viewControler = MovieDetailsViewController(viewModel: viewModel)
      self.navigationController.pushViewController(viewControler, animated: true)
    })
    .store(in: &cancellables)

    mainViewController.favoritesViewController.presentFilter
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] in
        self?.goToFilter()
      })
      .store(in: &cancellables)
  }

  private func goToFilter() {
    let filterCoordinator = FilterCoordinator(
      navigationController: navigationController,
      metadata: metaData.eraseToAnyPublisher()
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
