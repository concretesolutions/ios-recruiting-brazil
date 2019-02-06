//
//  FavoriteMoviesDelegate.swift
//  Movs
//
//  Created by Brendoon Ryos on 04/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

class FavoriteMoviesDelegate: NSObject, UITableViewDelegate {
  
  weak var tableView: FavoriteMoviesTableView?
  
  var didDeleteItemWith: ((IndexPath) -> ())?
  
  init(tableView: FavoriteMoviesTableView) {
    self.tableView = tableView
    super.init()
    self.tableView?.delegate = self
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return FavoriteMovieTableViewCell.height()
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: "Unfavorite") { (action, sourceView, completionHandler) in
      tableView.beginUpdates()
      tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.right)
      self.didDeleteItemWith?(indexPath)
      tableView.endUpdates()
      completionHandler(true)
    }
    
    deleteAction.backgroundColor = ColorPalette.red
    deleteAction.image = UIImage(named: "unfavorite")
    
    let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
    return swipeConfig
  }
}
