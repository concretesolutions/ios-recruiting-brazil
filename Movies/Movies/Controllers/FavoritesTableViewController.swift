//
//  FavoritesViewController.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 29/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit
import Reusable

class FavoritesTableViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.searchController = UISearchController(searchResultsController: nil)
    navigationItem.hidesSearchBarWhenScrolling = false
    
    tableView.register(cellType: FavoriteTableViewCell.self)
  }
  
  override func viewDidAppear(_ animated: Bool) {
      print(LocalStorage.shared.favoriteMoviesIds ?? "No Favorites")
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: FavoriteTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 169
  }
}
