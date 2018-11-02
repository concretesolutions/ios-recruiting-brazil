//
//  FavoritesViewController.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 29/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

class FavoritesCollectionViewController: UICollectionViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.searchController = UISearchController(searchResultsController: nil)
    navigationItem.hidesSearchBarWhenScrolling = false
  }
  
  override func viewDidAppear(_ animated: Bool) {
      print(LocalStorage.shared.favoriteMoviesIds ?? "No Favorites")
  }

}
