//
//  ViewController.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 29/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

class MoviesCollectionViewController: UICollectionViewController {
  var moviesDataSource: MoviesDataSource!
  
  var moviesDelegate: MoviesCollectionViewDelegate!
  
  fileprivate func fetchMovies() {
    NetworkClient().fetchPopularMovies { (result) in
      switch result {
      case .success(let movies):
        self.moviesDataSource.movies = movies
        self.collectionView.reloadData()
      case .failure(let error):
        print(error)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.searchController = UISearchController(searchResultsController: nil)
    navigationItem.hidesSearchBarWhenScrolling = false
    
    moviesDelegate = MoviesCollectionViewDelegate(frameWidth: view.frame.width)
    moviesDataSource = MoviesDataSource(posterHeight: moviesDelegate.newPosterHeight)
    self.collectionView.delegate = moviesDelegate
    self.collectionView.dataSource = moviesDataSource
    let movieCellNib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
    collectionView.register(movieCellNib, forCellWithReuseIdentifier: "movieCell")
    
    fetchMovies()
  }

}
