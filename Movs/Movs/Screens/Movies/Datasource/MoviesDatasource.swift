//
//  MoviesDatasource.swift
//  Movs
//
//  Created by Marcos Lacerda on 10/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class MoviesDatasource: NSObject, UICollectionViewDataSource {

  fileprivate var allMovies: [Movies] = []
  
  var delegate: MoviesActionDelegate!
  var movies: [Movies] = []
  var currentPage: Int = 1
  var totalPages: Int = 0

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
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell", for: indexPath) as? MoviesCollectionViewCell else {
      return MoviesCollectionViewCell()
    }
    
    let movie = movies[indexPath.row]

    cell.delegate = delegate
    cell.setup(with: movie)

    return cell
  }

}
