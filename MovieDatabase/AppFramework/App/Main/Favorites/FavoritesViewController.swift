import Combine
import CoreData
import UIKit

public final class FavoritesViewController: UIViewController {
  // MARK: Types

  final class DataSource: UITableViewDiffableDataSource<FavoritesSection, FavoriteViewModel> {
    private let _delete = PassthroughSubject<FavoriteViewModel?, Never>()
    lazy var delete: AnyPublisher<FavoriteViewModel?, Never> = {
      _delete.eraseToAnyPublisher()
    }()

    override func tableView(_: UITableView, canEditRowAt _: IndexPath) -> Bool {
      true
    }

    override func tableView(_: UITableView, commit _: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      let item = itemIdentifier(for: indexPath)
      _delete.send(item)
    }
  }

  typealias Snapshot = NSDiffableDataSourceSnapshot<FavoritesSection, FavoriteViewModel>

  // MARK: UI

  private let tableView: UITableView = {
    let tv = UITableView(frame: .zero, style: .plain)
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.rowHeight = 120
    tv.tableFooterView = UIView()
    tv.register(FavoriteCell.self)
    return tv
  }()

  private let tableViewBackgroundLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    return label
  }()

  private lazy var filterButton = UIBarButtonItem(
    image: UIImage(systemName: "line.horizontal.3.decrease.circle"),
    style: .plain,
    target: self,
    action: #selector(didTapFilter)
  )

  private let clearFilterButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Clear Filters", for: .normal)
    button.backgroundColor = .systemBackground
    return button
  }()

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

  private let _refreshValues = PassthroughSubject<Void, Never>()
  private let _presentMovieDetails = PassthroughSubject<Movie, Never>()
  public lazy var presentMovieDetails: AnyPublisher<Movie, Never> = _presentMovieDetails.eraseToAnyPublisher()
  private let _presentFilter = PassthroughSubject<Void, Never>()
  public lazy var presentFilter: AnyPublisher<Void, Never> = _presentFilter.eraseToAnyPublisher()
  fileprivate let _searhText = CurrentValueSubject<String?, Never>(nil)
  private let _clearFilter = PassthroughSubject<Void, Never>()

  // MARK: DataSource

  private lazy var dataSource: DataSource = {
    DataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
      let cell: FavoriteCell = tableView.dequeue(for: indexPath)
      cell.setup(with: item.movie)
      return cell
    })
  }()

  // MARK: Other Properties

  private let viewModel: FavoritesViewModel
  private var cancellables = Set<AnyCancellable>()

  // MARK: Lifecycle

  public init(viewModel: FavoritesViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
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

    view.addSubview(tableView)
    tableView.delegate = self

    view.addSubview(clearFilterButton)

    NSLayoutConstraint.activate([
      clearFilterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      clearFilterButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      clearFilterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      clearFilterButton.heightAnchor.constraint(equalToConstant: 44),
    ] + tableView.makeConstraintsToEdges(of: view))
  }

  private func setupBindings() {
    clearFilterButton.addTarget(self, action: #selector(didTapClearFilter), for: .primaryActionTriggered)

    let output = viewModel.transform(
      .init(
        refresh: _refreshValues
          .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
          .eraseToAnyPublisher(),
        delete: dataSource.delete,
        searchText: _searhText.eraseToAnyPublisher(),
        clearFilters: _clearFilter.eraseToAnyPublisher()
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

    output.filterOn
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] on in
        if on {
          self?.clearFilterButton.isHidden = false
          self?.tableView.contentInset = .init(top: 44, left: 0, bottom: 0, right: 0)
        } else {
          self?.clearFilterButton.isHidden = true
          self?.tableView.contentInset = .zero
        }
      })
      .store(in: &cancellables)

    Publishers.CombineLatest(output.filteredValues, output.filterOn)
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] values, filterOn in
        let empty = values.count == 0
        if empty {
          self?.tableViewBackgroundLabel.text = filterOn
            ? L10n.Screen.Favorites.noResultsFilter
            : L10n.Screen.Favorites.noFavorites
          self?.tableView.backgroundView = self?.tableViewBackgroundLabel
        } else {
          self?.tableView.backgroundView = nil
        }
      })
      .store(in: &cancellables)

    cancellables.formUnion(output.cancellables)
  }

  @objc private func didTapFilter() {
    _presentFilter.send(())
  }

  @objc private func didTapClearFilter() {
    _clearFilter.send(())
  }
}

// MARK: UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    _presentMovieDetails.send(item.movie)
  }

  public func tableView(_: UITableView, titleForDeleteConfirmationButtonForRowAt _: IndexPath) -> String? {
    L10n.Screen.Favorites.unfavorite
  }
}

// MARK: UISearchResultsUpdating

extension FavoritesViewController: UISearchResultsUpdating {
  public func updateSearchResults(for searchController: UISearchController) {
    _searhText.send(searchController.searchBar.text)
  }
}
