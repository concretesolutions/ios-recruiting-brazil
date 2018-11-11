//
//  MoviesCollectionDataSource.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 11/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

extension MoviesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.totalMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        let movie = self.presenter.interector.movies[indexPath.item]
        if let image = movie.poster_path {
            let imageURL = "https://image.tmdb.org/t/p/original\(image)"
            cell.awakeFromNib(title: movie.title, imageURL: imageURL)
        }else{
            cell.awakeFromNib(title: movie.title, imageURL: nil)
        }
        return cell
    }
    
}
