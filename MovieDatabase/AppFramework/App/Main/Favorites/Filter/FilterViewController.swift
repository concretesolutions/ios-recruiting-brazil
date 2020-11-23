import Combine
import UIKit

enum FilterSection: Hashable {
  case main
}

enum FilterItem: Hashable {
  case date(String?)
  case genres(Int?)
}

final class FilterCell: UITableViewCell {
  override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    accessoryType = .disclosureIndicator
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
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
      let cell: FilterCell = tableView.dequeue(for: indexPath)
      switch item {
      case let .date(date):
        cell.textLabel?.text = L10n.Screen.Favorites.Filter.date
        cell.detailTextLabel?.text = date
      case let .genres(quantity):
        cell.textLabel?.text = L10n.Screen.Favorites.Filter.genres
        cell.detailTextLabel?.text = quantity == nil
          ? nil
          : "\(quantity!) genres chosen"
      }
      return cell
    })
  }()

  init() {
    super.init(style: .grouped)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    title = L10n.Screen.Favorites.Filter.title
    tableView.register(FilterCell.self)

    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems([
      .date(nil),
      .genres(nil),
    ], toSection: .main)
    dataSource.apply(snapshot)
  }

  override public func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }

  override public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
    } else if indexPath.row == 1 {
      _presentGenres.send(())
    }
  }

  deinit {
    _finished.send(())
  }
}
