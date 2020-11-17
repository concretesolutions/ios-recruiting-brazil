import UIKit

public final class MoviesViewController: UICollectionViewController {
  public init() {
    let layout = UICollectionViewFlowLayout()
    super.init(collectionViewLayout: layout)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
