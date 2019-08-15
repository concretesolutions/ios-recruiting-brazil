//
//  MovieDetailDatasource.swift
//  Movs
//
//  Created by Marcos Lacerda on 14/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class MovieDetailDatasource: NSObject, UITableViewDataSource {
  
  var movie: Movies?
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movie != nil ? 1 : 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailCell") as? MovieDetailTableViewCell, let movie = self.movie else {
      return UITableViewCell()
    }
    
    cell.selectionStyle = .none
    cell.setup(with: movie)
    
    return cell
  }

}
