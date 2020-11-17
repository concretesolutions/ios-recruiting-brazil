import UIKit

public final class MoviesViewController: UICollectionViewController {

  public init() {
    let layout = UICollectionViewFlowLayout()
    super.init(collectionViewLayout: layout)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
