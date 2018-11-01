//
//  MoviesFavoritesCollectionViewCell.swift
//  AppMovie
//
//  Created by Renan Alves on 23/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class MoviesFavoritesCollectionViewCell: UICollectionViewCell {
    
    var movie = MovieNowPlaying()
    var delegate: FavoriteMovieDelegate?
    
    @IBOutlet weak var posterPath: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    @IBAction func favorite(_ sender: Any) {
        self.movie.updateFavorite()
        
        if let img = self.movie.getImage(favorite: self.movie.favorite){
            if self.movie.favorite == false {
                delegate?.removeFavorite(movie: movie)
            }else {
                delegate?.setFavorite(movie: movie)
            }
            self.btnFavorite.setImage(img, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        self.backgroundColor = Colors.backGroundCollectionViewCell.value
    }
}
