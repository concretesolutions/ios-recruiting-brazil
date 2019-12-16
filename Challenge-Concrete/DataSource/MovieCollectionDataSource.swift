//
//  MovieCollectionDataSource.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class MovieCollectionDataSource: GenericDataSource<Movie>, UICollectionViewDataSource {
    var currentPage: Int = 1

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    //TODO: Refactor the image request
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let movie = data[indexPath.row]
        let imageURL = "https://image.tmdb.org/t/p/w185/\(movie.posterPath ?? "")"
        cell.setupData(title: movie.title ?? movie.name)
        
        let alreadyFavorite = CoreDataManager.isSaved(entityType: FavoriteMovie.self, id: movie.id)
        movie.isFavorite = alreadyFavorite
        cell.changeFavoriteIcon(isAdding: alreadyFavorite)

        cell.imageView.setImage(withURL: imageURL) { imgData in
            movie.movieImageData = imgData
        }

        return cell
    }
}

extension MovieCollectionDataSource: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let countItems = collectionView.numberOfItems(inSection: 0)
        
        if countItems <= 20 {
            currentPage = 1
        }
        
        if indexPaths[0].item >= countItems - 5 {
            currentPage += 1
            dataFetchDelegate?.didChange(page: currentPage)
        }
    }
}
