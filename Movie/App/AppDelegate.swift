import class RxSwift.DisposeBag
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private let disposeBag = DisposeBag()

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        InitialCoordinator().start()
            .subscribe(onNext: { [weak self] viewController in
                self?.present(initial: viewController)
            }).disposed(by: disposeBag)

        return true
    }

    private func present(initial viewController: UIViewController) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
    }
}
