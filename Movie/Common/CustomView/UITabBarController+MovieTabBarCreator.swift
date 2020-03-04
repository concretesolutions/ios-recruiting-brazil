import class UIKit.UITabBarController
import class UIKit.UIViewController

protocol MovieTabBarCreator {
    func createMovieTabBar() -> UITabBarController
    func with(viewControllers: [UIViewController]) -> UITabBarController
}

extension UITabBarController: MovieTabBarCreator {
    func createMovieTabBar() -> UITabBarController {
        tabBar.isTranslucent = false
        tabBar.barTintColor = ColorName.primary.color
        tabBar.tintColor = ColorName.secondary.color
        return self
    }

    func with(viewControllers: [UIViewController]) -> UITabBarController {
        setViewControllers(viewControllers, animated: false)
        return self
    }
}
