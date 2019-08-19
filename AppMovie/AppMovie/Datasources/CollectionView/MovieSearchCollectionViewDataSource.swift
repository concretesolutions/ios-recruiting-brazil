//
//  MovieSearchCollectionViewDataSource.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 07/08/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

final class MovieSearchCollectionViewDataSource: NSObject, UICollectionViewDataSource{
    
    weak var delegate: MoviePagingDelegate?
    
    let movies:[Result]
    
    init(movies: [Result], collectionView:UICollectionView,delegate: MoviePagingDelegate) {
        self.movies = movies
        super.init()
        registerCells(in: collectionView)
        self.delegate = delegate
        collectionView.prefetchDataSource = self
    }
    
    private func registerCells(in collectionView: UICollectionView){
        collectionView.register(cellType: CellMovie.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                      cellType: CellMovie.self)
        let movie = movies[indexPath.row]
        cell.setup(movie: movie)
        return cell
    }
    
}

extension MovieSearchCollectionViewDataSource: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetch")
        let itemIndex = indexPaths.first!.row
        if itemIndex > (movies.count - 10) {
            delegate?.loadMovies()
        }
        
    }
}
