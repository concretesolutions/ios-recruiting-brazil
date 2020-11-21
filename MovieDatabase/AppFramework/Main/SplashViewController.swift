import UIKit

public final class SplashViewController: UIViewController {
  private let activityIndicator = UIActivityIndicatorView(style: .large)

  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    let imageView = UIImageView(image: UIImage(named: "Splash", in: Bundle.main, compatibleWith: nil))
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(imageView)
    view.addSubview(activityIndicator)

    let imageViewConstraints = imageView.makeConstraintsToEdges(of: view)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    let progressConstraints = [
      activityIndicator.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      activityIndicator.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 100),
    ]

    NSLayoutConstraint.activate(imageViewConstraints + progressConstraints)

    activityIndicator.startAnimating()
  }
}
