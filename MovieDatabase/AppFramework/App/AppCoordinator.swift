import Combine
import TheMovieDatabaseApi
import UIKit

public class AppCoordinator {
  private let window: UIWindow
  private let metaDataLoader: MetaDataLoader
  private let metadata = CurrentValueSubject<MetaData, Never>(.init(configuration: nil, genres: nil))

  private var cancellables = Set<AnyCancellable>()
  private var childCoordinators = [UUID: Any]()

  public init(window: UIWindow) {
    self.window = window
    metaDataLoader = MetaDataLoader()
  }

  public func start() {
    let splashViewController = SplashViewController()
    window.rootViewController = splashViewController
    window.makeKeyAndVisible()

    metaDataLoader.metaData
      .subscribe(metadata)
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
    let mainViewController = MainViewController(metaData: metadata.eraseToAnyPublisher())

    let moviesCoordinatorId = UUID()
    let moviesCoordinator = MoviesCoordinator(
      tabBarController: mainViewController,
      metadata: metadata
    )
    childCoordinators[moviesCoordinatorId] = moviesCoordinator
    moviesCoordinator.start()

    let favoritesCoordinatorId = UUID()
    let favoritesCoordinator = FavoritesCoordinator(
      tabBarController: mainViewController,
      metadata: metadata
    )
    childCoordinators[favoritesCoordinatorId] = favoritesCoordinator
    favoritesCoordinator.start()

    mainViewController.modalPresentationStyle = .fullScreen
    window.rootViewController?.present(mainViewController, animated: true, completion: { [weak self] in
      DispatchQueue.main.async {
        self?.window.rootViewController = mainViewController
      }
    })
  }
}
