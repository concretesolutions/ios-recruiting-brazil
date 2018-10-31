//
//  MoviesCollectionViewDelegate.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 31/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

class MoviesCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
  var cellWidth: CGFloat
  var newPosterHeight: CGFloat
  var margin: CGFloat = 16
  var columns: CGFloat = 2
  var posterHeight: CGFloat = 240
  var posterWidth: CGFloat = 160
  var movieInfoContainerHeight: CGFloat = 66
  var delegate: MoviesCollectionViewUpdateDelegate
  
  init(frameWidth: CGFloat, delegate: MoviesCollectionViewUpdateDelegate) {
    self.cellWidth = (frameWidth - (margin * (columns + 1))) / columns
    self.delegate = delegate
    newPosterHeight = posterHeight * cellWidth / posterWidth
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: cellWidth, height: newPosterHeight + movieInfoContainerHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
    
    if delegate.canShowFooter() {
      view.isHidden = false
      delegate.loadMoreMovies()
    }
    
  }

}
