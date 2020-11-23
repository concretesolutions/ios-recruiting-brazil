import Combine
import UIKit

public final class MainViewController: UITabBarController {
  let moviesViewController: MoviesViewController
  let favoritesViewController: FavoritesViewController

  public init(metaData: AnyPublisher<MetaData, Never>) {
    moviesViewController = Self.makeMoviesViewController(metaData: metaData)
    favoritesViewController = Self.makeFavoritesViewController(metaData: metaData)
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewDidLoad() {
    super.viewDidLoad()

    setViewControllers([
      moviesViewController,
      favoritesViewController,
    ], animated: false)
  }

  private static func makeMoviesViewController(metaData: AnyPublisher<MetaData, Never>) -> MoviesViewController {
    let viewController = MoviesViewController(viewModel: .default(metaData: metaData))
    viewController.tabBarItem = UITabBarItem(title: L10n.Screen.Movies.title, image: UIImage(systemName: "list.bullet"), selectedImage: nil)
    return viewController
  }

  private static func makeFavoritesViewController(metaData _: AnyPublisher<MetaData, Never>) -> FavoritesViewController {
    let viewController = FavoritesViewController()
    viewController.tabBarItem = UITabBarItem(title: L10n.Screen.Favorites.title, image: UIImage(systemName: "heart"), selectedImage: nil)
    return viewController
  }
}
