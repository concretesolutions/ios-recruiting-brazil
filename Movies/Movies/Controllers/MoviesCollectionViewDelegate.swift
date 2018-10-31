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
  
  init(frameWidth: CGFloat) {
    self.cellWidth = (frameWidth - (margin * (columns + 1))) / columns
    newPosterHeight = posterHeight * cellWidth / posterWidth
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: cellWidth, height: newPosterHeight + movieInfoContainerHeight)
  }
}
