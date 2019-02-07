//
//  FilterMoviesDataSource.swift
//  Movs
//
//  Created by Brendoon Ryos on 06/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

class FilterMoviesDataSource: NSObject {

  var items: [String] = ["Date", "Genre"]
  
  var values: [[String]] = [[String](), [String]()]
  
  var date: String = "None"
  var genre: String = "None"
  
  var handler: ((String, String) -> ())?
  
  var tableView: UITableView?
  var delegate: UITableViewDelegate?
  
  required init(tableView: UITableView, delegate: UITableViewDelegate) {
    self.tableView = tableView
    self.delegate = delegate
    super.init()
    setupTableView()
  }
  
  func registerTableView() {
    tableView?.register(cellType: FilterMoviesTableViewCell.self)
  }
  
  func update(genres: [String], dates: [String]) {
    values[0] = [date]
    values[0].append(contentsOf: dates.sorted { $0 > $1 })
    values[1] = [date]
    values[1].append(contentsOf: genres.sorted { $0 < $1 }) 
    tableView?.reloadData()
  }
}

extension FilterMoviesDataSource: ItemsTableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FilterMoviesTableViewCell.self)
    let title = items[indexPath.row]
    let values = self.values[indexPath.row]
    cell.values = values
    cell.selectedRow = 0
    cell.delegate = self
    cell.leftLabel.text = title
    return cell
  }
}

extension FilterMoviesDataSource: FilterPickerCellDelegate {
  func filterPickerCell(_ cell: FilterMoviesTableViewCell, didPick row: Int, value: String) {
    if cell.leftLabel.text == items.first {
      date = value
    } else {
      genre = value
    }
    
    handler?(date, genre)
  }
}
