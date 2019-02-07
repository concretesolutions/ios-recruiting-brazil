//
//  FilterMoveisDelegate.swift
//  Movs
//
//  Created by Brendoon Ryos on 06/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

class FilterMoviesDelegate: NSObject, UITableViewDelegate {

  weak var tableView: FilterMoviesTableView?
  
  init(tableView: FilterMoviesTableView) {
    self.tableView = tableView
    super.init()
    self.tableView?.delegate = self
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if let cell = tableView.cellForRow(at: indexPath) as? FilterMoviesTableViewCell {
      return cell.height
    }
    return FilterMoviesTableViewCell.height()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if let cell = tableView.cellForRow(at: indexPath) as? FilterMoviesTableViewCell {
      cell.selectedInTableView(tableView)
    }
  }
}
