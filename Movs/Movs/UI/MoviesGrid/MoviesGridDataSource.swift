//
//  MoviesGridDataSource.swift
//  Movs
//
//  Created by Gabriel Reynoso on 23/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class MoviesGridDataSource: NSObject, UICollectionViewDataSource {
    
    let cache = ImageCache.global
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
        
        cell.delegate = self.cellDelegate
        cell.setupView()
        cell.configure(with: movie)
        self.cache.getImage(for: movie.w92PosterPath) { img in
            guard let image = img else { return }
            cell.setMovieImageView(image: image)
        }
        
        return cell
    }
}
