//
//  MoviePreviewCollectionViewCell.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 11/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit

class MoviePreviewCollectionViewCell: UICollectionViewCell {
    
    var movie: Movie?
    
    @IBOutlet weak var moviePosterImageViewOutlet: UIImageView!
    @IBOutlet weak var movieTitleLabelOutlet: UILabel!
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    
    func setupCell(image: UIImage, title: String, movie: Movie){
        
        self.movie = movie
        self.moviePosterImageViewOutlet.image = image
        self.movieTitleLabelOutlet.text = title
        
    }
    
    @IBAction func favoriteMovieButtonTapped(_ sender: Any) {
    
        if let movie = self.movie{
            MovieDAO.saveMovieAsFavorite(movie: movie)
        }
        
        
    }
    
}
