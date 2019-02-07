//
//  FavoriteMoviesTableView.swift
//  Movs
//
//  Created by Brendoon Ryos on 04/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

class FavoriteMoviesTableView: UITableView {

  fileprivate var didDeleteItem: ((CDMovie) -> ())?
  fileprivate var customDataSource: FavoriteMoviesDataSource?
  fileprivate var customDelegate: FavoriteMoviesDelegate?
  
  lazy var headerButton: UIButton = {
    let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: self.frame.width, height: 0)))
    button.backgroundColor = ColorPalette.yellow
    button.setTitle("Remove Filter", for: .normal)
    button.setTitleColor(ColorPalette.black, for: .normal)
    button.titleLabel?.font = UIFont(name: FontNames.bold, size: 20)
    button.alpha = 0
    return button
  }()
  
  convenience init() {
    self.init(frame: .zero, style: .plain)
  }
  
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    tableHeaderView = headerButton
    customDelegate = FavoriteMoviesDelegate(tableView: self)
    customDataSource = FavoriteMoviesDataSource(tableView: self, delegate: customDelegate!)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func showHeader() {
    headerButton.frame.size.height = 45
    headerButton.alpha = 1
  }
  
  func hideHeader() {
    headerButton.frame.size.height = 0
    headerButton.alpha = 0
  }
}

extension FavoriteMoviesTableView {
  func updateItems(_ items: [CDMovie]) {
    customDataSource?.updateItems(items)
  }
  
  func setDeletionHandler(_ handler: @escaping (CDMovie) -> ()) {
    didDeleteItem = handler
    customDelegate?.didDeleteItemWith = didDeleteItemWith
  }
  
  private func didDeleteItemWith(_ indexPath: IndexPath) {
    guard let dataSource = customDataSource else { return }
    guard dataSource.filteredItems.count >= indexPath.item else { return }
    let item = dataSource.filteredItems[indexPath.item]
    didDeleteItem?(item)
  }
}
