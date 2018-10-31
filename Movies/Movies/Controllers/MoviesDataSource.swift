//
//  MoviesDataSource.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 31/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

class MoviesDataSource: NSObject, UICollectionViewDataSource {
  
  var movies: [Movie]
  var posterHeight: CGFloat
  
  init(posterHeight: CGFloat) {
    movies = []
    self.posterHeight = posterHeight
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell {
      cell.configure(withMovie: movies[indexPath.row])
      cell.posterHeightLayoutConstraint.constant = posterHeight
      collectionView.layoutIfNeeded()
      return cell
    }
    
    return UICollectionViewCell()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let cell =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerCell", for: indexPath)
    cell.isHidden = true
    return cell
  }
}
