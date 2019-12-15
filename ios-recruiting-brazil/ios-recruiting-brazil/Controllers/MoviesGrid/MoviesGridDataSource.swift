//
//  MoviesDataSource.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
extension MoviesGridController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MoviesCollectionViewCell.self)
        let movie = movies[indexPath.row]
        cell.movie = movie
        cell.buildCell()
        cell.delegate = self

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 5 {
            pagesRequested += 1
            requestMovies(page: pagesRequested)
        }
    }

}
