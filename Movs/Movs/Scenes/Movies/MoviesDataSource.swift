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
    collectionView?.reloadData()
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
}
