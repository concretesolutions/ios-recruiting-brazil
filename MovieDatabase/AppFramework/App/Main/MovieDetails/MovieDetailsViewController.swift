import Combine
import UIKit

final class MovieDetailPosterCell: UITableViewCell {
  private let posterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.masksToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    contentView.addSubview(posterImageView)
    NSLayoutConstraint.activate(posterImageView.makeConstraintsToEdges(of: contentView))
  }

  func setup(with url: URL) {
    posterImageView.kf.setImage(with: url)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

final class MovieDetailTitleCell: UITableViewCell {
  override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    textLabel?.numberOfLines = 0
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

final class MovieDetailYearCell: UITableViewCell {
  override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

final class MovieDetailGenresCell: UITableViewCell {
  override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    textLabel?.numberOfLines = 0
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

final class MovieDetailOverviewCell: UITableViewCell {
  override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    textLabel?.numberOfLines = 0
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

public enum MovieDetailsSection: Hashable {
  case main
}

public enum MovieDetailItem: Hashable {
  case poster(String)
  case title(String)
  case year(String)
  case genres([String])
  case overview(String)
}

public struct MovieDetailsViewModel {
  public let id: Int64
  public let poster: String
  public let title: String
  public let year: String
  public let genres: [String]
  public let overview: String

  public init(
    id: Int64,
    poster: String,
    title: String,
    year: String,
    genres: [String],
    overview: String
  ) {
    self.id = id
    self.poster = poster
    self.title = title
    self.year = year
    self.genres = genres
    self.overview = overview
  }
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
      case let .title(title):
        let cell: MovieDetailTitleCell = tableView.dequeue(for: indexPath)
        cell.textLabel?.text = title
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

    var snapshot = Snapshot()
    snapshot.appendSections([.main])
    snapshot.appendItems([
      .poster(viewModel.poster),
      .title(viewModel.title),
      .year(viewModel.year),
      .genres(viewModel.genres),
      .overview(viewModel.overview),
    ])

    dataSource.apply(snapshot)
  }
}
