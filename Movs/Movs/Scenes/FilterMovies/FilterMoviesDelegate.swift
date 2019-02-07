//
//  FilterMoveisDelegate.swift
//  Movs
//
//  Created by Brendoon Ryos on 06/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

class FilterMoveisDelegate: NSObject, UITableViewDelegate {

  weak var tableView: FavoriteMoviesTableView?
  
  init(tableView: FavoriteMoviesTableView) {
    self.tableView = tableView
    super.init()
    self.tableView?.delegate = self
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return FilterMoviesTableViewCell.height()
  }
}
