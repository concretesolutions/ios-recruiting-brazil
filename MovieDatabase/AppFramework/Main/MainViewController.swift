import UIKit

public final class MainViewController: UITabBarController {

  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    setViewControllers([
      makeMoviesViewController(),
    ], animated: false)

  }

  private func makeMoviesViewController() -> UIViewController {
    let viewController = MoviesViewController()
    viewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "list.bullet"), selectedImage: nil)
    return viewController
  }

}
