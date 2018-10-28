//
//  MoviesFavoritesCollectionViewCell.swift
//  AppMovie
//
//  Created by Renan Alves on 23/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class MoviesFavoritesCollectionViewCell: UICollectionViewCell {
    
    var movie = Movie()
    var delegate: FavoriteMovieDelegate?
    
    @IBOutlet weak var posterPath: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    @IBAction func favorite(_ sender: Any) {
        if btnFavorite.imageView?.image == UIImage(named: "favorite_empty_icon") {
            btnFavorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            delegate?.setFavorite(movie: movie)
        }else {
            btnFavorite.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
            delegate?.removeFavorite(movie: movie)
        }
    }
}
