import class RxSwift.Observable
import class UIKit.UITabBarController
import class UIKit.UIViewController

final class InitialCoordinator: Coordinator {
    func start() -> Observable<UIViewController> {
        Observable.zip(AllMoviesCoordinator().start(), FavoritesMoviesCoordinator().start())
            .take(1)
            .map { allMoviesVC, favoriteMoviesVC in
                UITabBarController()
                    .createMovieTabBar()
                    .with(viewControllers: [allMoviesVC, favoriteMoviesVC])
            }
    }
}
