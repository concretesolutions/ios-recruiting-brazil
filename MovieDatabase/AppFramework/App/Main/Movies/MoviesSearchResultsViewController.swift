import Combine
import UIKit

public final class MoviesSearchResultsViewController: UICollectionViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<MoviesSection, MovieViewModel>
  typealias Snapshot = NSDiffableDataSourceSnapshot<MoviesSection, MovieViewModel>

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
}
