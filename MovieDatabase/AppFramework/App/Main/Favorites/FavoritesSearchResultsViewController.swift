import UIKit

public final class FavoritesSearchResultsViewController: UITableViewController {
  typealias DataSource = UITableViewDiffableDataSource<FavoritesSection, FavoriteViewModel>
  typealias Snapshot = NSDiffableDataSourceSnapshot<FavoritesSection, FavoriteViewModel>

  lazy var dataSource: DataSource = {
    DataSource(tableView: tableView) { tableView, indexPath, item in
      let cell: FavoriteCell = tableView.dequeue(for: indexPath)
      cell.textLabel?.text = item.movie.title
      cell.detailTextLabel?.text = item.movie.overview
      return cell
    }
  }()

  override public func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(FavoriteCell.self)
  }
}
