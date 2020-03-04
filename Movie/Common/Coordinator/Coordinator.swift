import class RxSwift.Observable
import class UIKit.UIViewController

protocol Coordinator {
    func start() -> Observable<UIViewController>
}
