import Combine
import UIKit

public final class MoviesViewController: UICollectionViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<MoviesViewModel.Section, MovieViewModel>
  typealias Snapshot = NSDiffableDataSourceSnapshot<MoviesViewModel.Section, MovieViewModel>

  private var cancellables = Set<AnyCancellable>()
  private let viewModel: MoviesViewModel

  private lazy var dataSource: DataSource = {
    DataSource(collectionView: collectionView) { collectionView, indexPath, movieViewModel -> UICollectionViewCell? in
      let cell: MovieCell = collectionView.dequeue(for: indexPath)
      cell.setup(viewModel: movieViewModel)
      return cell
    }
  }()

  private static func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.46),
      heightDimension: .fractionalHeight(1.0)
    )

    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .absolute(200)
    )

    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item]
    )
    group.interItemSpacing = NSCollectionLayoutSpacing.flexible(16)
    group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: .fixed(24))

    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24)

    let layout = UICollectionViewCompositionalLayout(section: section)

    return layout
  }

  public init(viewModel: MoviesViewModel) {
    self.viewModel = viewModel
    let layout = Self.makeCollectionViewLayout()
    super.init(collectionViewLayout: layout)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(MovieCell.self)

    let refresh = PassthroughSubject<Void, Never>()
    let nextPage = PassthroughSubject<Void, Never>()

    let (values, error) = viewModel.setupBindings(
      refresh: refresh.eraseToAnyPublisher(),
      nextPage: nextPage.eraseToAnyPublisher()
    )

    values
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] movies in
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        self?.dataSource.apply(snapshot)
      })
      .store(in: &cancellables)

    error
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { error in
        print("Error:", error.statusCode, error.statusMessage)
      })
      .store(in: &cancellables)

    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
      refresh.send(())
    }
  }

  override public func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tabBarController?.title = "Movies"
  }

  override public func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    tabBarController?.title = nil
  }
}
