//
//  MoviesCollectionViewDelegate.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 31/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//

import UIKit

final class MoviesCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
  
  // MARK: Properties
  
  let cellWidth: CGFloat
  
  let newPosterHeight: CGFloat
  
  let margin: CGFloat = 16
  
  let columns: CGFloat = 2
  
  let posterHeight: CGFloat = 240
  
  let posterWidth: CGFloat = 160
  
  let movieInfoContainerHeight: CGFloat = 66
  
  let updateDelegate: MoviesCollectionViewUpdateDelegate
  
  let itemSelectDelegate: CollectionViewdidSelectItemDelegate
  
  // MARK: Initialization
  
  init(frameWidth: CGFloat, updateDelegate: MoviesCollectionViewUpdateDelegate, itemSelectDelegate: CollectionViewdidSelectItemDelegate) {
    self.cellWidth = (frameWidth - (margin * (columns + 1))) / columns
    self.updateDelegate = updateDelegate
    self.itemSelectDelegate = itemSelectDelegate
    newPosterHeight = posterHeight * cellWidth / posterWidth
  }
  
  // MARK: Table view delegate
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: cellWidth, height: newPosterHeight + movieInfoContainerHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
    if updateDelegate.canShowFooter() {
      view.isHidden = false
      updateDelegate.loadMoreMovies()
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    itemSelectDelegate.didSelectIndexPath(indexPath)
  }
  
}

protocol CollectionViewdidSelectItemDelegate: class {
  func didSelectIndexPath(_ indexPath: IndexPath)
}
