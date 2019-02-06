//
//  ItemsTableViewDataSource.swift
//  Movs
//
//  Created by Brendoon Ryos on 04/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

protocol ItemsTableViewDataSource: UITableViewDataSource {
  associatedtype T
  var items:[T] { get }
  var tableView: UITableView? { get }
  var delegate: UITableViewDelegate? { get }
  
  init(tableView: UITableView, delegate: UITableViewDelegate)
  
  func setupTableView()
  func registerTableView()
}

extension ItemsTableViewDataSource {
  func setupTableView() {
    registerTableView()
    self.tableView?.dataSource = self
    self.tableView?.delegate = self.delegate
    self.tableView?.reloadData()
  }
  
  func registerTableView() {
    
  }
}
