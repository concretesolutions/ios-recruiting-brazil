import Combine
import UIKit

public final class MainViewController: UITabBarController {
  private var _presentMovieDetails = PassthroughSubject<Movie, Never>()
  public lazy var presentMovieDetails: AnyPublisher<Movie, Never> = _presentMovieDetails.eraseToAnyPublisher()

  private let metaData: AnyPublisher<MetaData, Never>
  var cancellables = Set<AnyCancellable>()

  public init(metaData: AnyPublisher<MetaData, Never>) {
    self.metaData = metaData
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewDidLoad() {
    super.viewDidLoad()

    setViewControllers([
      makeMoviesViewController(),
      makeFavoritesViewController(),
    ], animated: false)
  }

  private func makeMoviesViewController() -> UIViewController {
    let viewController = MoviesViewController(viewModel: .default(metaData: metaData))
    viewController.tabBarItem = UITabBarItem(title: L10n.Screen.Movies.title, image: UIImage(systemName: "list.bullet"), selectedImage: nil)
    viewController
      .presentMovieDetails
      .subscribe(_presentMovieDetails)
      .store(in: &cancellables)
    return viewController
  }

  private func makeFavoritesViewController() -> UIViewController {
    let viewController = FavoritesViewController()
    viewController.tabBarItem = UITabBarItem(title: L10n.Screen.Favorites.title, image: UIImage(systemName: "heart"), selectedImage: nil)
    viewController
      .presentMovieDetails
      .subscribe(_presentMovieDetails)
      .store(in: &cancellables)
    return viewController
  }
}
