import class RxSwift.Observable
import UIKit

final class AllMoviesCoordinator: Coordinator {
    func start() -> Observable<UIViewController> {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        viewController.tabBarItem = UITabBarItem()
            .createMovieTabBarItem()
            .with(title: L10n.TabBar.allMovies)
        return Observable.just(viewController)
    }
}
