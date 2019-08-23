//
//  MoviesViewController.swift
//  Movies Concrete
//
//  Created by Taina Viriato on 21/08/19.
//  Copyright © 2019 tainavm. All rights reserved.
//

import UIKit

// MARK: Delegate

protocol MoviesViewControllerDelegate: class {
  func didTapInfo()
  func showMovieDetail(url: String)
}

class MoviesViewController: BaseViewController {
  
  // MARK: Members
  
  var moviesList = [Movie]()
  @IBOutlet weak var popularCollectionView: UICollectionView!
  weak var delegate: MoviesViewControllerDelegate?
  var request = MoviesServices()
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    request.getPopularMovies(data: self, collectionView: popularCollectionView)
    
    popularCollectionView.dataSource = self
    popularCollectionView.delegate = self
    popularCollectionView.register(UINib(nibName: "PopularMoviesCollectionViewCell", bundle: nil),
                                   forCellWithReuseIdentifier: "PopularMoviesCollectionViewCell")
    
  }
  
  // MARK: Functions
  
  
  
}

// MARK: Extensions

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return moviesList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: "PopularMoviesCollectionViewCell", for: indexPath) as! PopularMoviesCollectionViewCell
    
    let movie = moviesList[indexPath.row]
    
    cell.titleMovie.text = movie.title
    
    return cell
    
  }
  
  
}

