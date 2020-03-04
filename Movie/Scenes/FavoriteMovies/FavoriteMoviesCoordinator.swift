import class RxSwift.Observable
import class UIKit.UITabBarItem
import class UIKit.UIViewController

final class FavoritesMoviesCoordinator: Coordinator {
    func start() -> Observable<UIViewController> {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .yellow
        viewController.tabBarItem = UITabBarItem()
            .createMovieTabBarItem()
            .with(title: L10n.TabBar.favoriteMovies)
            .with(image: Asset.favoriteEmptyIcon.image)
        return Observable.just(viewController)
    }
}
