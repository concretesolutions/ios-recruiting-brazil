//
//  PopularMoviesCollectionViewDatasource.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

final class PopularMoviesCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    public var movies:[Movie]
    weak var delegate: CollectionViewPagingDelegate?
    
    init(movies: [Movie], collectionView: UICollectionView, delegate: CollectionViewPagingDelegate) {
        self.movies = movies
        super.init()
        self.delegate = delegate
        registerCells(in: collectionView)
        collectionView.prefetchDataSource = self
    }
    
    private func registerCells(in collectionView: UICollectionView) {
        collectionView.register(cellType: PopularMoviesCollectionViewCell.self)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PopularMoviesCollectionViewCell.self)
        cell.setup(movie: movies[indexPath.row])
        return cell
    }
    
}

extension PopularMoviesCollectionViewDataSource: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let itemIndex = indexPaths.first!.row
        if itemIndex > (movies.count - 10) {
            delegate?.shouldFetchNextPage()
        }
    }
}
