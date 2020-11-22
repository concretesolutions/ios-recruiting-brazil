import Combine
import UIKit

public enum MovieDetailsSection: Hashable {
  case main
}

public final class MovieDetailsViewController: UITableViewController {
  typealias DataSource = UITableViewDiffableDataSource<MovieDetailsSection, MovieDetailItem>
  typealias Snapshot = NSDiffableDataSourceSnapshot<MovieDetailsSection, MovieDetailItem>

  private var cancellables = Set<AnyCancellable>()
  private let viewModel: MovieDetailsViewModel
  private lazy var dataSource: DataSource = {
    DataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
      switch item {
      case let .poster(poster):
        let cell: MovieDetailPosterCell = tableView.dequeue(for: indexPath)
        cell.setup(with: URL(string: poster)!)
        return cell
      case let .title(titleViewModel):
        let cell: MovieDetailTitleCell = tableView.dequeue(for: indexPath)
        cell.setup(with: titleViewModel)
        return cell
      case let .year(year):
        let cell: MovieDetailYearCell = tableView.dequeue(for: indexPath)
        cell.textLabel?.text = year
        return cell
      case let .genres(genres):
        let cell: MovieDetailGenresCell = tableView.dequeue(for: indexPath)
        cell.textLabel?.text = genres.joined(separator: ", ")
        return cell
      case let .overview(overview):
        let cell: MovieDetailOverviewCell = tableView.dequeue(for: indexPath)
        cell.textLabel?.text = overview
        return cell
      }
    })
  }()

  private let _disappearPublisher = PassthroughSubject<Void, Never>()
  private lazy var disappearPublisher = _disappearPublisher.eraseToAnyPublisher()

  init(viewModel: MovieDetailsViewModel) {
    self.viewModel = viewModel
    super.init(style: .plain)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "Movie"
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(MovieDetailPosterCell.self)
    tableView.register(MovieDetailTitleCell.self)
    tableView.register(MovieDetailYearCell.self)
    tableView.register(MovieDetailGenresCell.self)
    tableView.register(MovieDetailOverviewCell.self)

    tableView.tableFooterView = UIView()

    let titleViewModel = MovieDetailTitleViewModel.default(title: viewModel.movie.title, initialLiked: false)
    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems([
      .poster(viewModel.movie.posterUrl.absoluteString),
      .title(titleViewModel),
      .year(viewModel.movie.year),
      .genres(viewModel.movie.genreIds.map(String.init)),
      .overview(viewModel.movie.overview),
    ])

    dataSource.apply(snapshot)
  }

  override public func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    _disappearPublisher.send(())
  }
}
