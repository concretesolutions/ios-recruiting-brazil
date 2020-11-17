import AppFramework
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    let window = UIWindow(frame: UIScreen.main.bounds)
    let rootViewController = UINavigationController(rootViewController: MainViewController())
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
    self.window = window

    return true
  }
}
