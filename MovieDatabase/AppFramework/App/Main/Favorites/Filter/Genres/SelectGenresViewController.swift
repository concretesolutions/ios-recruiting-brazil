import Combine
import UIKit

public final class SelectGenresViewController: UITableViewController {
  typealias DataSource = UITableViewDiffableDataSource<GenreSection, GenreItem>
  typealias Snapshot = NSDiffableDataSourceSnapshot<GenreSection, GenreItem>

  private lazy var dataSource: DataSource = {
    DataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
      let cell: UITableViewCell = tableView.dequeue(for: indexPath)
      cell.textLabel?.text = item.genre.name
      cell.accessoryType = item.selected
        ? .checkmark
        : .none
      return cell
    })
  }()

  private lazy var clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(didTapClear))

  private let _clear = PassthroughSubject<Void, Never>()
  private let _didSelectItem = PassthroughSubject<GenreItem, Never>()
  private var cancellables = Set<AnyCancellable>()
  private let viewModel: SelectGenresViewModel

  init(viewModel: SelectGenresViewModel) {
    self.viewModel = viewModel
    super.init(style: .grouped)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    title = L10n.Screen.Favorites.Filter.genres
    navigationItem.rightBarButtonItem = clearButton
    tableView.register(UITableViewCell.self)

    dataSource.defaultRowAnimation = .fade

    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems([])
    dataSource.apply(snapshot)

    let output = viewModel.transform(
      .init(
        clear: _clear.eraseToAnyPublisher(),
        selectedGenre: _didSelectItem.eraseToAnyPublisher()
      )
    )

    output.values
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: { [weak self] items in
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        self?.dataSource.apply(snapshot)
      })
      .store(in: &cancellables)

    cancellables.formUnion(output.cancellables)
  }

  override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    _didSelectItem.send(item)
  }

  @objc private func didTapClear() {
    _clear.send(())
  }
}
