import Combine
import CoreData
import UIKit

public final class FavoritesViewController: UITableViewController {
  // MARK: Types

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

  // MARK: UI

  private let _refreshValues = PassthroughSubject<Void, Never>()
  private lazy var filterButton = UIBarButtonItem(
    image: UIImage(systemName: "line.horizontal.3.decrease.circle"),
    style: .plain,
    target: self,
    action: #selector(didTapFilter)
  )

  private lazy var searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.autocapitalizationType = .none
    searchController.searchResultsUpdater = self
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.automaticallyShowsSearchResultsController = false
    searchController.obscuresBackgroundDuringPresentation = false
    return searchController
  }()

  // MARK: Publishers

  private let _presentMovieDetails = PassthroughSubject<Movie, Never>()
  public lazy var presentMovieDetails: AnyPublisher<Movie, Never> = _presentMovieDetails.eraseToAnyPublisher()
  private let _presentFilter = PassthroughSubject<Void, Never>()
  public lazy var presentFilter: AnyPublisher<Void, Never> = _presentFilter.eraseToAnyPublisher()
  fileprivate let _searhText = CurrentValueSubject<String?, Never>(nil)

  // MARK: DataSource

  private lazy var dataSource: DataSource = {
    DataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
      let cell: FavoriteCell = tableView.dequeue(for: indexPath)
      cell.textLabel?.text = item.movie.title
      cell.detailTextLabel?.text = item.movie.overview
      return cell
    })
  }()

  // MARK: Other Properties

  private let viewModel: FavoritesViewModel
  private var cancellables = Set<AnyCancellable>()

  // MARK: Lifecycle

  public init(viewModel: FavoritesViewModel) {
    self.viewModel = viewModel
    super.init(style: .plain)
    definesPresentationContext = true
    title = L10n.Screen.Favorites.title
    tabBarItem = UITabBarItem(title: L10n.Screen.Favorites.title, image: UIImage(systemName: "heart"), selectedImage: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBindings()
  }

  override public func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    _refreshValues.send(())
  }

  // MARK: Methods

  private func setupUI() {
    dataSource.defaultRowAnimation = .fade
    navigationItem.searchController = searchController
    navigationItem.rightBarButtonItem = filterButton
    tableView.tableFooterView = UIView()
    tableView.register(FavoriteCell.self)
  }

  private func setupBindings() {
    let output = viewModel.transform(
      .init(
        refresh: _refreshValues
          .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
          .eraseToAnyPublisher(),
        delete: dataSource.delete,
        searchText: _searhText.eraseToAnyPublisher()
      )
    )

    output.filteredValues
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] favorites in
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(favorites)
        self?.dataSource.apply(snapshot)
      })
      .store(in: &cancellables)
  }

  @objc private func didTapFilter() {
    _presentFilter.send(())
  }

  // MARK: UITableViewDelegate

  override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    _presentMovieDetails.send(item.movie)
  }

  override public func tableView(_: UITableView, titleForDeleteConfirmationButtonForRowAt _: IndexPath) -> String? {
    L10n.Screen.Favorites.unfavorite
  }
}

// MARK: UISearchResultsUpdating

extension FavoritesViewController: UISearchResultsUpdating {
  public func updateSearchResults(for searchController: UISearchController) {
    _searhText.send(searchController.searchBar.text)
  }
}
