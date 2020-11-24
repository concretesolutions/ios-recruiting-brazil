import Combine
import UIKit

public final class MainViewController: UITabBarController {
  public init(metaData _: AnyPublisher<MetaData, Never>) {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
  }
}
