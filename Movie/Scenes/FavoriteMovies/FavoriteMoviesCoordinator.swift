import class RxSwift.Observable
import class UIKit.UITabBarItem
import class UIKit.UIViewController

final class FavoritesMoviesCoordinator: Coordinator {
    func start() -> Observable<UIViewController> {
        let viewController = UIViewController()
        viewController.tabBarItem = UITabBarItem(title: "Favorite", image: nil, selectedImage: nil)
        return Observable.just(viewController)
    }
}
