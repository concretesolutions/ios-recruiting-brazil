import Combine
import UIKit

public final class FavoritesViewController: UITableViewController {
  final class DataSource: UITableViewDiffableDataSource<FavoritesSection, FavoriteViewModel> {
    override func tableView(_: UITableView, canEditRowAt _: IndexPath) -> Bool {
      true
    }

    override func tableView(_: UITableView, commit _: UITableViewCell.EditingStyle, forRowAt _: IndexPath) {
      print("Delete")
    }
  }

  typealias Snapshot = NSDiffableDataSourceSnapshot<FavoritesSection, FavoriteViewModel>

  private let viewModel: FavoritesViewModel
  private var cancellables = Set<AnyCancellable>()
  private lazy var dataSource: DataSource = {
    DataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
      let cell: FavoriteCell = tableView.dequeue(for: indexPath)
      cell.textLabel?.text = item.title
      cell.detailTextLabel?.text = item.overview
      return cell
    })
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
    tableView.tableFooterView = UIView()
    tableView.register(FavoriteCell.self)

    dataSource.defaultRowAnimation = .fade

    let refresh = PassthroughSubject<Void, Never>()

    let output = viewModel.transform(
      .init(
        refresh: refresh
          .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
          .eraseToAnyPublisher()
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

    refresh.send(())
  }

  override public func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tabBarController?.title = "Favorites"
  }

  override public func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    tabBarController?.title = nil
  }

  override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

  override public func tableView(_: UITableView, titleForDeleteConfirmationButtonForRowAt _: IndexPath) -> String? {
    "Unfavorite"
  }
}
