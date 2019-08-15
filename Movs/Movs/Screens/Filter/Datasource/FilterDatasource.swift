//
//  FilterDatasource.swift
//  Movs
//
//  Created by Marcos Lacerda on 12/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class FilterDatasource: NSObject, UITableViewDataSource {
  
  var filtersApplyed: Filters = Filters()
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return FilterOptions.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell") as? FilterTableViewCell else {
      return UITableViewCell()
    }
    
    cell.selectionStyle = .none

    let filter = FilterOptions.allCases[indexPath.row]
    cell.setup(with: filter, filter: filtersApplyed)
    
    return cell
  }
  
}
