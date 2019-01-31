//
//  MoviesDelegate.swift
//  Movs
//
//  Created by Brendoon Ryos on 25/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit
import Reusable
import SnapKit

class MoviesDelegate: NSObject {
  
  weak var collectionView: MoviesCollectionView?
  
  var didSelectItemWith: ((IndexPath) -> ())?
  
  private var latestIndexes: [IndexPath] = []
  
  init(collectionView: MoviesCollectionView) {
    self.collectionView = collectionView
    super.init()
    self.collectionView?.delegate = self
  }
  
}

extension MoviesDelegate: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if !latestIndexes.contains(indexPath) {
      latestIndexes.append(indexPath)
      cell.transform = CGAffineTransform(translationX: 0, y: 40)
      
      UIView.beginAnimations("translation", context: nil)
      UIView.setAnimationDuration(0.5)
      cell.transform = CGAffineTransform.identity
      UIView.commitAnimations()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    UIView.animate(withDuration: 0.075) {
      cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    
    UIView.animate(withDuration: 0.075) {
      cell?.transform = CGAffineTransform.identity
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as! MovieCollectionViewCell
    
    UIView.animate(withDuration: 0.075, animations: {
      cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    }) { _ in
      UIView.animate(withDuration: 0.07, animations: {
        cell.transform = CGAffineTransform.identity
      }) { _ in
        self.didSelectItemWith?(indexPath)
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width
    return MovieCollectionViewCell.size(for: width)
  }
}
