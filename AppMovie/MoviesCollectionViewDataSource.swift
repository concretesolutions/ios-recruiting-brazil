//
//  MoviesCollectionViewDataSource.swift
//  AppMovie
//
//  Created by Renan Alves on 23/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class MoviesCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var datas = [NSDictionary]()
    var controller = UIViewController()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCollectionMovies", for: indexPath) as! MoviesFavoritesCollectionViewCell
        
        cell.delegate = controller as! FavoriteMovieDelegate
        let movie = self.datas[indexPath.row]
        cell.movie = movie
        cell.titleMovie.text = movie[KeyAccesPropertiesMovieNowPlaying.title.value] as? String
        if let nameImage = movie[KeyAccesPropertiesMovieNowPlaying.posterPath.value] as? String {
            cell.posterPath.image = MovieDAO.shared.requestImage(from: APILinks.posterPath.value, name: nameImage, imageFormate: "jpg")
        }
        return cell
    }
}
extension MoviesCollectionViewDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clickei em: \(indexPath.row)")
    }
    
}
