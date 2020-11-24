import Combine
import UIKit

enum FilterSection: Hashable {
  case main
  case apply
}

enum FilterItem: Hashable {
  case date(String?)
  case genres(Int?)
  case apply
}

public final class FilterViewController: UITableViewController {
  typealias DataSource = UITableViewDiffableDataSource<FilterSection, FilterItem>
  typealias Snapshot = NSDiffableDataSourceSnapshot<FilterSection, FilterItem>

  private let _finished = PassthroughSubject<Void, Never>()
  public lazy var finished = _finished.eraseToAnyPublisher()
  private let _presentGenres = PassthroughSubject<Void, Never>()
  public lazy var presentGenres: AnyPublisher<Void, Never> = _presentGenres.eraseToAnyPublisher()

  private lazy var dataSource: DataSource = {
    DataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
      switch item {
      case let .date(date):
        let cell: FilterCell = tableView.dequeue(for: indexPath)
        cell.textLabel?.text = L10n.Screen.Favorites.Filter.date
        cell.detailTextLabel?.text = date
        return cell
      case let .genres(quantity):
        let cell: FilterCell = tableView.dequeue(for: indexPath)
        cell.textLabel?.text = L10n.Screen.Favorites.Filter.genres
        cell.detailTextLabel?.text = quantity == nil
          ? nil
          : "\(quantity!) genres chosen"
        return cell
      case .apply:
        let cell: ButtonCell = tableView.dequeue(for: indexPath)
        cell.setup(with: "Apply")
        return cell
      }
    })
  }()

  init() {
    super.init(style: .grouped)
    hidesBottomBarWhenPushed = true
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    title = L10n.Screen.Favorites.Filter.title
    tableView.register(FilterCell.self)
    tableView.register(ButtonCell.self)

    var snapshot = Snapshot()
    snapshot.appendSections([.main, .apply])
    snapshot.appendItems([
      .date(nil),
      .genres(nil),
    ], toSection: .main)

    snapshot.appendItems([.apply], toSection: .apply)
    dataSource.apply(snapshot)
  }

  override public func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }

  override public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    switch item {
    case .date: break
    case .genres: _presentGenres.send(())
    case .apply: break
    }
  }

  deinit {
    _finished.send(())
  }
}
