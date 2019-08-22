//
//  FavoritesDatasource.swift
//  Movs
//
//  Created by Marcos Lacerda on 11/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class FavoritesDatasource: NSObject, UITableViewDataSource {

  var movies: [Movies] = []
  var allMovies: [Movies] = []

  var inSearch: Bool = false {
    didSet {
      if inSearch {
        allMovies.removeAll()
        allMovies.append(contentsOf: movies)
      } else {
        self.movies.removeAll()
        self.movies.append(contentsOf: allMovies)
      }
    }
  }
  
  var filterEnable: Bool = false {
    didSet {
      if filterEnable {
        allMovies.removeAll()
        allMovies.append(contentsOf: movies)
      } else {
        self.movies.removeAll()
        self.movies.append(contentsOf: allMovies)
      }
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell") as? FavoritesTableViewCell else {
      return UITableViewCell()
    }
    
    cell.selectionStyle = .none
    
    let movie = movies[indexPath.row]
    cell.setup(with: movie)

    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

}
