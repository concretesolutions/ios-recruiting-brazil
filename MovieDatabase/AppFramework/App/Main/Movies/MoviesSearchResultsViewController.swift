import Combine
import Design
import UIKit

public final class MoviesSearchResultsViewController: UICollectionViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<MoviesSection, MovieViewModel>
  typealias Snapshot = NSDiffableDataSourceSnapshot<MoviesSection, MovieViewModel>

  private let _didSelectItem = PassthroughSubject<MovieViewModel, Never>()
  public lazy var didSelectItem = _didSelectItem.eraseToAnyPublisher()

  private lazy var noResultsBackground: UIView = {
    let label = UILabel()
    label.textAlignment = .center
    label.text = L10n.Screen.Movies.emptyResultsMessage
    return label
  }()

  lazy var dataSource: DataSource = {
    DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, movieViewModel -> UICollectionViewCell? in
      guard let self = self else { return nil }
      let cell: MovieCell = collectionView.dequeue(for: indexPath)
      cell.setup(
        viewModel: movieViewModel,
        refresh: Empty<Void, Never>(completeImmediately: false)
          .eraseToAnyPublisher()
      )
      return cell
    }
  }()

  override public func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(MovieCell.self)
    collectionView.backgroundColor = .systemBackground
  }

  override public func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    _didSelectItem.send(item)
  }

  public func setEmptyResultsBackground() {
    collectionView.backgroundView = noResultsBackground
  }

  public func removeEmptyResultsBackground() {
    collectionView.backgroundView = nil
  }
}
