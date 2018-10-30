//
//  ViewController.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 29/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

class MoviesCollectionViewController: UICollectionViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    NetworkClient().fetchPopularMovies { (result) in
      switch result {
      case .success(let movies):
        print(movies)
      case .failure(let error):
        print(error)
      }
    }
    navigationItem.searchController = UISearchController(searchResultsController: nil)
    navigationItem.hidesSearchBarWhenScrolling = false
  }

}
