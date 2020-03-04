import class RxSwift.Observable
import class UIKit.UITabBarItem
import class UIKit.UIViewController

final class FavoritesMoviesCoordinator: Coordinator {
    func start() -> Observable<UIViewController> {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .yellow
        viewController.tabBarItem = UITabBarItem(title: L10n.TabBar.favoriteMovies,
                                                 image: nil, selectedImage: nil)
        return Observable.just(viewController)
    }
}
