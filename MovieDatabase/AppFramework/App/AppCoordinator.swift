import Combine
import UIKit

public class AppCoordinator {
  private let window: UIWindow
  private let navigationController: UINavigationController

  private var cancellables = Set<AnyCancellable>()

  public init(window: UIWindow) {
    self.window = window
    navigationController = UINavigationController()
  }

  public func start() {
    let mainViewController = MainViewController()
    navigationController.addChild(mainViewController)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()

    mainViewController.presentMovieDetails
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] viewModel in
        let viewControler = MovieDetailsViewController(viewModel: viewModel)
        self?.navigationController.pushViewController(viewControler, animated: true)
      })
      .store(in: &cancellables)
  }
}
