//
//  FilterMoviesTableView.swift
//  Movs
//
//  Created by Brendoon Ryos on 06/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

class FilterMoviesTableView: UITableView {
  
  fileprivate var customDataSource: FilterMoviesDataSource?
  fileprivate var customDelegate: FilterMoviesDelegate?
  convenience init() {
    self.init(frame: .zero, style: .plain)
  }
  
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    customDelegate = FilterMoviesDelegate(tableView: self)
    customDataSource = FilterMoviesDataSource(tableView: self, delegate: customDelegate!)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension FilterMoviesTableView {
  
  func setFilterHandler(_ handler: @escaping (String, String) -> ()) {
    customDataSource?.handler = handler
  }
  
  func update(genres: [String], dates: [String]) {
    customDataSource?.update(genres: genres, dates: dates)
  }
}
