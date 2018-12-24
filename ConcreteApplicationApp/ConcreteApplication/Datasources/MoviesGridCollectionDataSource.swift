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

//FIXME:- change protocol position
protocol MoviesSelectionDelegate: class {
    func didSelectMovie(movie: Movie)
}

protocol MoviesGridPagingDelegate: class {
    func shouldFetch(page: Int)
}

final class MoviesGridCollectionDataSource: NSObject, UICollectionViewDataSource{
    
    var movies:[Movie] = []
    var pagingDelegate: MoviesGridPagingDelegate?
    
    required init(movies:[Movie], collectionView: UICollectionView, pagingDelegate: MoviesGridPagingDelegate) {
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

class MoviesGridCollectionDelegate: NSObject, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    var movies:[Movie]!
    let numberOfItems = 2
    let moviesDelegate: MoviesSelectionDelegate?
    
    init(movies: [Movie], delegate: MoviesSelectionDelegate){
        self.movies = movies
        self.moviesDelegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let items = CGFloat(numberOfItems)
        let width = (UIScreen.main.bounds.width - Design.Insets.moviesGridCollection.right * (items + 1)) / items
        return CGSize(width: width, height: width * 1.50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MoviesGridCollectionViewCell{
            movies[indexPath.row].poster = cell.imageView.image
        }
        moviesDelegate?.didSelectMovie(movie: movies[indexPath.row])
    }
    
    
}
