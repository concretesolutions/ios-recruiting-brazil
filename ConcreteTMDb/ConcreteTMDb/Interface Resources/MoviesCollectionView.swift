//
//  MoviesCollectionView.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 14/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import UIKit

class MoviesCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Properties
    
    var movies: [Movie] = []
    weak var movieSelected: MovieCellSelected?
    weak var loadContent: LoadMoreContentAfterPagination?
    
    // MARK: - UICollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MoviesCollectionViewCell
        
        let movie = self.movies[indexPath.row]
        cell.setup(movie: movie)
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellTapped = collectionView.cellForItem(at: indexPath) as? MoviesCollectionViewCell else { return }
        self.movieSelected?.didTap(at: cellTapped)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == self.movies.count - 1 {
            if let loadDelegate = self.loadContent {
                loadDelegate.loadMoreMovies()
            }
        }
        
    }
    
}
