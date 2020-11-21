import Combine
import UIKit

public final class MainViewController: UITabBarController {
  private var _presentMovieDetails = PassthroughSubject<MovieDetailsViewModel, Never>()
  public lazy var presentMovieDetails: AnyPublisher<MovieDetailsViewModel, Never> = _presentMovieDetails.eraseToAnyPublisher()

  var cancellables = Set<AnyCancellable>()

  public init() {
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
    let viewController = MoviesViewController()
    viewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "list.bullet"), selectedImage: nil)
    viewController
      .presentMovieDetails
      .subscribe(_presentMovieDetails)
      .store(in: &cancellables)
    return viewController
  }

  private func makeFavoritesViewController() -> UIViewController {
    let viewController = FavoritesViewController()
    viewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: nil)
    viewController
      .presentMovieDetails
      .subscribe(_presentMovieDetails)
      .store(in: &cancellables)
    return viewController
  }
}
