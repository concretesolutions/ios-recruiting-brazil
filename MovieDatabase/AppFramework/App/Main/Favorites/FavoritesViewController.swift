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
  fileprivate let _searhText = CurrentValueSubject<String?, Never>(nil)

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

  private lazy var filterButton = UIBarButtonItem(
    image: UIImage(systemName: "line.horizontal.3.decrease.circle"),
    style: .plain,
    target: self,
    action: #selector(didTapFilter)
  )
  private let resultsController = FavoritesSearchResultsViewController()
  private lazy var searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: resultsController)
    searchController.searchBar.autocapitalizationType = .none
    searchController.searchResultsUpdater = self
    return searchController
  }()

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
    definesPresentationContext = true

    tableView.tableFooterView = UIView()
    tableView.register(FavoriteCell.self)

    dataSource.defaultRowAnimation = .fade

    let output = viewModel.transform(
      .init(
        refresh: _refreshValues
          .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
          .eraseToAnyPublisher(),
        delete: dataSource.delete,
        searchText: _searhText.eraseToAnyPublisher()
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

    output.filteredValues
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] favorites in
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(favorites)
        self?.resultsController.dataSource.apply(snapshot)
      })
      .store(in: &cancellables)
  }

  override public func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tabBarController?.navigationItem.title = L10n.Screen.Favorites.title
    tabBarController?.navigationItem.searchController = searchController
    tabBarController?.navigationItem.rightBarButtonItem = filterButton
    _refreshValues.send(())
  }

  override public func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    tabBarController?.navigationItem.searchController = nil
    tabBarController?.navigationItem.rightBarButtonItem = nil
  }

  override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    _presentMovieDetails.send(item.movie)
  }

  override public func tableView(_: UITableView, titleForDeleteConfirmationButtonForRowAt _: IndexPath) -> String? {
    L10n.Screen.Favorites.unfavorite
  }

  @objc private func didTapFilter() {
    let viewControler = FilterViewController()
    navigationController?.pushViewController(viewControler, animated: true)
  }
}

extension FavoritesViewController: UISearchResultsUpdating {
  public func updateSearchResults(for searchController: UISearchController) {
    _searhText.send(searchController.searchBar.text)
  }
}
