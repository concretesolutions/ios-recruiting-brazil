//
//  GenericListDatasource.swift
//  Movs
//
//  Created by Marcos Lacerda on 12/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class GenericListDatasource: NSObject, UITableViewDataSource {
  
  var items: [String] = []
  var selectedIndexes: [IndexPath] = []
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "GenericListItemCell") else {
      return UITableViewCell()
    }
    
    cell.selectionStyle = .none
    cell.accessoryType = selectedIndexes.contains(indexPath) ? .checkmark : .none
    cell.tintColor = #colorLiteral(red: 0.9647058824, green: 0.8078431373, blue: 0.3568627451, alpha: 1)
    
    let item = items[indexPath.row]
    
    cell.textLabel?.text = item
    cell.textLabel?.textColor = #colorLiteral(red: 0.168627451, green: 0.1843137255, blue: 0.2745098039, alpha: 1)
    
    return cell
  }
  
}
