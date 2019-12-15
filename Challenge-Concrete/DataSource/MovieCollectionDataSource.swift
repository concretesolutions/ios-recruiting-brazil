//
//  MovieCollectionDataSource.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class MovieCollectionDataSource: GenericDataSource<Movie>, UICollectionViewDataSource {
    
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
