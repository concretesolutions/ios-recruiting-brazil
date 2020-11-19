import Combine
import UIKit

public final class MoviesViewController: UICollectionViewController {
  typealias DataSource = UICollectionViewDiffableDataSource<MoviesViewModel.Section, MovieViewModel>
  typealias Snapshot = NSDiffableDataSourceSnapshot<MoviesViewModel.Section, MovieViewModel>

  private var cancellables = Set<AnyCancellable>()
  private let viewModel: MoviesViewModel
  private let refreshControl = UIRefreshControl()
  private let _refresh = PassthroughSubject<Void, Never>()
  private let _nextPage = PassthroughSubject<Int, Never>()

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
    refreshControl.addTarget(self, action: #selector(refresh), for: .primaryActionTriggered)

    collectionView.backgroundColor = .systemBackground

    collectionView.register(MovieCell.self)
    collectionView.refreshControl = refreshControl

    let (values, error, isRefreshing) = viewModel.setupBindings(
      refresh: _refresh
        .throttle(for: .milliseconds(1500), scheduler: DispatchQueue.main, latest: true)
        .eraseToAnyPublisher(),
      nextPage: _nextPage
        .removeDuplicates()
        .map { _ in () }
        .throttle(for: .milliseconds(1500), scheduler: DispatchQueue.main, latest: true)
        .eraseToAnyPublisher()
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

    isRefreshing
      .filter { !$0 }
      .delay(for: .milliseconds(500), scheduler: DispatchQueue.main)
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] _ in
        self?.refreshControl.endRefreshing()
      })
      .store(in: &cancellables)
  }

  var viewAlredyAppeared = false
  override public func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tabBarController?.title = "Movies"
    if !viewAlredyAppeared {
      _refresh.send(())
    }
    viewAlredyAppeared = true
  }

  override public func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    tabBarController?.title = nil
  }

  @objc private func refresh() {
    guard refreshControl.isRefreshing else { return }
    _refresh.send(())
  }

  override public func collectionView(_ collectionView: UICollectionView, willDisplay _: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let numberOfItems = collectionView.numberOfItems(inSection: 0)
    if indexPath.item == numberOfItems - 1 {
      _nextPage.send(numberOfItems)
    }
  }
}
