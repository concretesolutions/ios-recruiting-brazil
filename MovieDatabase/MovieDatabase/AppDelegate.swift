import AppFramework
import Design
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  private var coordinator: AppCoordinator!

  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Env.database.loadStore()
    setupAppearance()
    let window = UIWindow(frame: UIScreen.main.bounds)
    coordinator = AppCoordinator(window: window)
    self.window = window
    coordinator.start()
    return true
  }
}
