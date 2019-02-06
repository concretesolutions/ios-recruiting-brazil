//
//  FavoriteMoviesDataSource.swift
//  Movs
//
//  Created by Brendoon Ryos on 04/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

final class FavoriteMoviesDataSource: NSObject {
  
  var items: [CDMovie] = [] {
    didSet {
      filteredItems = items
    }
  }
  
  var filteredItems: [CDMovie] = [] {
    didSet {
      tableView?.reloadData()
    }
  }
  
  var tableView: UITableView?
  
  var delegate: UITableViewDelegate?
  
  init(tableView: UITableView, delegate: UITableViewDelegate) {
    self.tableView = tableView
    self.delegate = delegate
    super.init()
    setupTableView()
  }
  
  func registerTableView() {
    tableView?.register(cellType: FavoriteMovieTableViewCell.self)
  }
  
  func updateItems(_ items: [CDMovie]) {
    self.items = items
  }
}

extension FavoriteMoviesDataSource: ItemsTableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FavoriteMovieTableViewCell.self)
    let movie = filteredItems[indexPath.row]
    cell.setup(with: movie)
    return cell
  }
}
