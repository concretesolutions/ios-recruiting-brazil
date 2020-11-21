import Combine
import TheMovieDatabaseApi
import UIKit

public class AppCoordinator {
  private let window: UIWindow
  private let navigationController: UINavigationController
  private let metaDataLoader: MetaDataLoader

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
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] _ in
        self?.cancellables.removeAll()
        self?.startMain()
      })
      .store(in: &cancellables)

    metaDataLoader.reloadMetaData()
  }

  private func startMain() {
    let mainViewController = MainViewController()
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
