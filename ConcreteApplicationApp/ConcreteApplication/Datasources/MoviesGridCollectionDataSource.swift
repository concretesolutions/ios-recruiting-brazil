//
//  MoviesGridCollectionDataSource.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation
import UIKit
import Reusable

protocol MoviesSelectionDelegate: class {
    func didSelectMovie(movie: Movie)
}

protocol MoviesGridPagingDelegate: class {
    func shouldFetch(page: Int)
}

final class MoviesGridCollectionDataSource: NSObject, UICollectionViewDataSource{
    
    var movies:[Movie] = []
    var pagingDelegate: MoviesGridPagingDelegate?
    
    init(movies:[Movie], collectionView: UICollectionView, pagingDelegate: MoviesGridPagingDelegate) {
        self.movies = movies
        self.pagingDelegate = pagingDelegate
        super.init()
        collectionView.register(cellType: MoviesGridCollectionViewCell.self)
        collectionView.prefetchDataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MoviesGridCollectionViewCell.self)
        cell.setup(movie: movies[indexPath.row])
        return cell
    }
}

extension MoviesGridCollectionDataSource: UICollectionViewDataSourcePrefetching{
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let itemsPerRow = 2
        if ((indexPaths.first?.row ?? 0) - 6) > (self.movies.count / itemsPerRow) {
            let nextPage = Int(self.movies.count/(itemsPerRow * 10) + 1)
            self.pagingDelegate?.shouldFetch(page: nextPage)
        }
    }
    
}


