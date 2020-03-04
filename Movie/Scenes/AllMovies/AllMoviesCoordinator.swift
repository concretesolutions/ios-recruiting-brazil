import class RxSwift.Observable
import class UIKit.UITabBarItem
import class UIKit.UIViewController

final class AllMoviesCoordinator: Coordinator {
    func start() -> Observable<UIViewController> {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        viewController.tabBarItem = UITabBarItem(title: L10n.TabBar.allMovies,
                                                 image: nil, selectedImage: nil)
        return Observable.just(viewController)
    }
}
