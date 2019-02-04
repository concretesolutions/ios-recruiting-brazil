//
//  MoviesDataSource.swift
//  Movs
//
//  Created by Brendoon Ryos on 24/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import UIKit

class MoviesDataSource: NSObject {
  
  weak var collectionView: MoviesCollectionView?
  private var searchingState: SearchingState = .none
  
  var items: [Movie] = [] {
    didSet {
      filteredItems = items
    }
  }
  
  var filteredItems: [Movie] = [] {
    didSet {
      collectionView?.reloadData()
    }
  }
  
  init(collectionView: MoviesCollectionView) {
    self.collectionView = collectionView
    super.init()
    setup()
  }
  
  func updateItems(_ items: [Movie], searchingState: SearchingState = .none) {
    self.searchingState = searchingState
    switch searchingState {
    case .begin:
      self.filteredItems = items
    case .ended:
      self.items = items
    default:
      self.items.append(contentsOf: items)
    }
  }
  
  private func setup() {
    collectionView?.dataSource = self
    collectionView?.register(cellType: MovieCollectionViewCell.self)
    collectionView?.register(MovieCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: MovieCollectionReusableView.self))
  }
}

extension MoviesDataSource: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filteredItems.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCollectionViewCell.self)
    cell.tag = indexPath.row
    let movie = filteredItems[indexPath.row]
    
    cell.setup(with: movie, hasPoster: movie.posterPath != .none)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: MovieCollectionReusableView.self), for: indexPath) as! MovieCollectionReusableView
    
    if searchingState != .begin {
      footer.activityIndicator.startAnimating()
    } else {
      footer.activityIndicator.stopAnimating()
    }
    return footer
  }
}
