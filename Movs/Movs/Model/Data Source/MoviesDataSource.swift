//
//  MoviesDataSource.swift
//  Movs
//
//  Created by Julio Brazil on 25/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MoviesCell"

extension MoviesCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesTotal
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        }
        
        if !isLoadingCell(for: indexPath) {
            let movie = movies[indexPath.row]
            cell.movie = movie
            cell.toggle.isOn = FavoriteManager.shared.existsMovie(withID: movie.id)
            cell.toggle.toggleAction = { isOn in
                if isOn {
                    FavoriteManager.shared.favoriteMovie(movie)
                } else {
                    FavoriteManager.shared.unfavoriteMovie(withID: movie.id)
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) && !self.isFetching {
            self.isFetching = true
            TMDBManager.shared.getNextPage { [weak self](response) in
                guard let self = self else {return}
                self.handleDataFetch(response, isUpdating: true)
            }
        }
    }
}
