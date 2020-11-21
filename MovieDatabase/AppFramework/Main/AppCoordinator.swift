import UIKit

public class AppCoordinator {
  private let window: UIWindow
  private let navigationController: UINavigationController

  public var childCoordinators: [Any] = []

  public init(window: UIWindow) {
    self.window = window
    navigationController = UINavigationController()
  }

  public func start() {
    let mainViewController = MainViewController()
    navigationController.addChild(mainViewController)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
}
