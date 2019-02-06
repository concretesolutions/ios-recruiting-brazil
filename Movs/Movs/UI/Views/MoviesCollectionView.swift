//
//  MoviesCollectionView.swift
//  Movs
//
//  Created by Brendoon Ryos on 24/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

class MoviesCollectionView: UICollectionView {
  
  fileprivate var didSelectItem: ((Movie) -> ())?
  fileprivate var customDataSource: MoviesDataSource?
  fileprivate var customDelegate: MoviesDelegate?

  convenience init() {
    let layout = UICollectionViewFlowLayout()
    let spacing = AppearanceProxyHelper.collectionViewSpacing
    layout.minimumLineSpacing = spacing
    layout.minimumInteritemSpacing = spacing
    layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    self.init(frame: .zero, collectionViewLayout: layout)
  }
  
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    customDelegate = MoviesDelegate(collectionView: self)
    customDataSource = MoviesDataSource(collectionView: self, delegate: customDelegate!)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MoviesCollectionView {
  
  func setSelectionHandler(_ handler: @escaping (Movie) -> ()) {
    didSelectItem = handler
    customDelegate?.didSelectItemWith = didSelectItemWith
  }
  
  private func didSelectItemWith(_ indexPath: IndexPath) {
    guard let dataSource = customDataSource else { return }
    guard dataSource.filteredItems.count >= indexPath.item else { return }
    let item = dataSource.filteredItems[indexPath.item]
    didSelectItem?(item)
  }
  
  func updateItems(_ items: [Movie], searchingState: SearchingState) {
    customDataSource?.updateItems(items, searchingState: searchingState)
  }
}
