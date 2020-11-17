import UIKit

public extension UICollectionViewCell {
  static var reuseIdentifier: String { String(describing: self) }
}

public extension UICollectionView {
  func register<T: UICollectionViewCell>(_ cellType: T.Type) {
    register(cellType, forCellWithReuseIdentifier: T.reuseIdentifier)
  }

  func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
    dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
  }
}
