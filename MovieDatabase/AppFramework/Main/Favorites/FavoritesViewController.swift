import Combine
import UIKit

public extension UITableViewCell {
  static var reuseIdentifier: String { String(describing: self) }
}

public extension UITableView {
  func register<T: UITableViewCell>(_ cellType: T.Type) {
    register(cellType, forCellReuseIdentifier: T.reuseIdentifier)
  }

  func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
  }
}

public enum FavoritesSection: Hashable {
  case main
}

public final class FavoritesViewController: UITableViewController {
  typealias DataSource = UITableViewDiffableDataSource<FavoritesSection, FavoriteViewModel>
  typealias Snapshot = NSDiffableDataSourceSnapshot<FavoritesSection, FavoriteViewModel>

  private let viewModel: FavoritesViewModel
  private var cancellables = Set<AnyCancellable>()
  private lazy var dataSource: DataSource = {
    DataSource(tableView: tableView, cellProvider: { tableView, _, item in
      let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier)
      cell?.textLabel?.text = item.uuid.uuidString
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
    tableView.register(UITableViewCell.self)

    dataSource.defaultRowAnimation = .fade

    let output = viewModel.transform(
      .init()
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
    tabBarController?.title = "Favorites"
  }

  override public func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    tabBarController?.title = nil
  }
}
