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
