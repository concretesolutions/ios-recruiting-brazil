//
//  ViewController.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 29/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

class MoviesCollectionViewController: UICollectionViewController {
  var cellWidth: CGFloat!
  
  var movies: [Movie] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    
    let movieCellNib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
    collectionView.register(movieCellNib, forCellWithReuseIdentifier: "movieCell")
    
    cellWidth = (view.frame.size.width - 32 - 16) / 2
    if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
        layout.itemSize.width = cellWidth
        layout.itemSize.height = (240 * cellWidth / 160) + 66
    }
    
    NetworkClient().fetchPopularMovies { (result) in
      switch result {
      case .success(let movies):
        self.movies = movies
        self.collectionView.reloadData()
      case .failure(let error):
        print(error)
      }
    }
    
    navigationItem.searchController = UISearchController(searchResultsController: nil)
    navigationItem.hidesSearchBarWhenScrolling = false
  }

}

extension MoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell {
      cell.configure(movie: movies[indexPath.row])
      cell.posterHeightLayoutConstraint.constant = cell.posterHeightLayoutConstraint.constant * cellWidth / 160
      self.view.layoutIfNeeded()
      return cell
    }
    
    return UICollectionViewCell()
  }
  
}
