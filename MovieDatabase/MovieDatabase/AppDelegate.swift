import AppFramework
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  private var coordinator: AppCoordinator!

  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Env.database.loadStore()
    let window = UIWindow(frame: UIScreen.main.bounds)
    coordinator = AppCoordinator(window: window)
    self.window = window
    coordinator.start()
    return true
  }
}
