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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let movie = data[indexPath.row]
        let imageURL = "https://image.tmdb.org/t/p/w185/\(movie.posterPath!)"
        cell.setupData(title: movie.title ?? movie.name)
        cell.imageView.setImage(withURL: imageURL)
        return cell
    }
}
