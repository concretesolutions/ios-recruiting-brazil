//
//  MoviesCollectionViewDataSource.swift
//  AppMovie
//
//  Created by Renan Alves on 23/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var datas = [MovieNowPlaying]()
    var controller = UIViewController()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCollectionMovies", for: indexPath) as! MoviesFavoritesCollectionViewCell
        
        cell.delegate = controller as? FavoriteDelegate
        let _movie = self.datas[indexPath.row]
        cell.movie = _movie
        cell.titleMovie.text = _movie.originalTitle
        cell.posterPath.image = _movie.posterPath
        cell.btnFavorite.setImage(_movie.getImage(favorite: _movie.favorite), for: .normal)
        
        return cell
    }
}

