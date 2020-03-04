import class RxSwift.Observable
import class UIKit.UITabBarItem
import class UIKit.UIViewController

final class AllMoviesCoordinator: Coordinator {
    func start() -> Observable<UIViewController> {
        let viewController = UIViewController()
        viewController.tabBarItem = UITabBarItem(title: "Filmes", image: nil, selectedImage: nil)
        return Observable.just(viewController)
    }
}
