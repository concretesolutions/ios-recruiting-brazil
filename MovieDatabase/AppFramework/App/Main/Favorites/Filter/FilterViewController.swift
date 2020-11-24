import Combine
import UIKit

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
      case let .date(dateSubject):
        let cell: FilterDateCell = tableView.dequeue(for: indexPath)
        cell.setup(subject: dateSubject)
        return cell
      case let .genres(detailsPub):
        let cell: FilterCell = tableView.dequeue(for: indexPath)
        cell.setup(
          title: L10n.Screen.Favorites.Filter.genres,
          detailValue: detailsPub
        )
        return cell
      case let .apply(subject):
        let cell: ButtonCell = tableView.dequeue(for: indexPath)
        cell.setup(with: "Apply", subject: subject)
        return cell
      }
    })
  }()

  private var cancellables = Set<AnyCancellable>()
  private let viewModel: FilterViewModel

  init(viewModel: FilterViewModel) {
    self.viewModel = viewModel
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
    tableView.rowHeight = 44
    tableView.register(FilterDateCell.self)
    tableView.register(FilterCell.self)
    tableView.register(ButtonCell.self)

    let output = viewModel.transform()

    var snapshot = Snapshot()
    snapshot.appendSections([.main, .apply])
    snapshot.appendItems([
      .date(output.currentDate),
      .genres(output.genreDetails),
    ], toSection: .main)
    snapshot.appendItems([
      .apply(output.apply),
    ], toSection: .apply)
    dataSource.apply(snapshot)

    output.apply
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] in
        self?.navigationController?.popViewController(animated: true)
      })
      .store(in: &cancellables)

    cancellables.formUnion(output.cancellables)
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
