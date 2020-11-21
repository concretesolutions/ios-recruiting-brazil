import Combine
import TheMovieDatabaseApi
import UIKit

public class AppCoordinator {
  private let window: UIWindow
  private let navigationController: UINavigationController
  private let metaDataLoader: MetaDataLoader
  private let metaData = CurrentValueSubject<MetaData, Never>(.init(configuration: nil, genres: nil))

  private var cancellables = Set<AnyCancellable>()

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

    mainViewController.presentMovieDetails
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] viewModel in
        let viewControler = MovieDetailsViewController(viewModel: viewModel)
        self?.navigationController.pushViewController(viewControler, animated: true)
      })
      .store(in: &cancellables)
  }
}
