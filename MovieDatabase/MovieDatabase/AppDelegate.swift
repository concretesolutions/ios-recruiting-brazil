import AppFramework
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  let window = UIWindow()

  private lazy var coordinator = AppCoordinator(window: window)

  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Env.database.loadStore()
    coordinator.start()
    return true
  }
}
