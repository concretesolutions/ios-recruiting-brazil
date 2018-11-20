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
    
    init(movies: [Movie], collectionView: UICollectionView) {
        self.movies = movies
        super.init()
        registerCells(in: collectionView)
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

extension MutableCollection {
    mutating func map(transform: (Element) -> Element) {
        if isEmpty { return }
        var index = self.startIndex
        for element in self {
            self[index] = transform(element)
            formIndex(after: &index)
        }
    }
}
