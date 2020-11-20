import AppFramework
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Env.database.loadStore()

    let window = UIWindow(frame: UIScreen.main.bounds)
    let rootViewController = UINavigationController(rootViewController: MainViewController())
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
    self.window = window

    return true
  }
}
