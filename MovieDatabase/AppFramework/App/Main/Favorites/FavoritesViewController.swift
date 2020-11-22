import Combine
import CoreData
import UIKit

public final class FavoritesViewController: UITableViewController {
  final class DataSource: UITableViewDiffableDataSource<FavoritesSection, FavoriteViewModel> {
    private let _delete = PassthroughSubject<IndexPath, Never>()
    lazy var delete: AnyPublisher<IndexPath, Never> = {
      _delete.eraseToAnyPublisher()
    }()

    override func tableView(_: UITableView, canEditRowAt _: IndexPath) -> Bool {
      true
    }

    override func tableView(_: UITableView, commit _: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      _delete.send(indexPath)
    }
  }

  typealias Snapshot = NSDiffableDataSourceSnapshot<FavoritesSection, FavoriteViewModel>

  private let _presentMovieDetails = PassthroughSubject<Movie, Never>()
  public lazy var presentMovieDetails: AnyPublisher<Movie, Never> = _presentMovieDetails.eraseToAnyPublisher()

  private let viewModel: FavoritesViewModel
  private var cancellables = Set<AnyCancellable>()
  private lazy var dataSource: DataSource = {
    DataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
      let cell: FavoriteCell = tableView.dequeue(for: indexPath)
      cell.textLabel?.text = item.movie.title
      cell.detailTextLabel?.text = item.movie.overview
      return cell
    })
  }()

  private let _refreshValues = PassthroughSubject<Void, Never>()

  public init(viewModel: FavoritesViewModel = .default()) {
    self.viewModel = viewModel
    super.init(style: .plain)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
    tableView.register(FavoriteCell.self)

    dataSource.defaultRowAnimation = .fade

    let output = viewModel.transform(
      .init(
        refresh: _refreshValues
          .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
          .eraseToAnyPublisher(),
        delete: dataSource.delete
      )
    )

    output.values
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] favorites in
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(favorites)
        self?.dataSource.apply(snapshot)
      })
      .store(in: &cancellables)
  }

  override public func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tabBarController?.title = L10n.Screen.Favorites.title
    _refreshValues.send(())
  }

  override public func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    tabBarController?.title = nil
  }

  override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    _presentMovieDetails.send(item.movie)
  }

  override public func tableView(_: UITableView, titleForDeleteConfirmationButtonForRowAt _: IndexPath) -> String? {
    L10n.Screen.Favorites.unfavorite
  }
}
