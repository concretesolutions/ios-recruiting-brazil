//
//  MoviesGridDataSource.swift
//  Movs
//
//  Created by Gabriel Reynoso on 23/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MoviesGridDataSource: NSObject, UICollectionViewDataSource {
    
    let cache = ImageCache()
    var items:[Movie]
    
    unowned let cellDelegate:MoviesGridCellDelegate
    
    init(cellDelegate:MoviesGridCellDelegate, items:[Movie]? = nil) {
        self.cellDelegate = cellDelegate
        self.items = items ?? []
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesGridCell.identifier, for: indexPath) as? MoviesGridCell else {
            return UICollectionViewCell()
        }
        
        let movie = self.items[indexPath.row]
        let imgLink = "\(API.imageLink)/w92\(movie.posterPath)"
        
        cell.setupView()
        cell.delegate = self.cellDelegate
        self.cache.getImage(for: imgLink) {
            cell.configure(with: movie, and: $0)
        }
        
        return cell
    }
}
