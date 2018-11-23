//
//  MoviePreviewCollectionViewCell.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 11/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit
import Kingfisher

class MoviePreviewCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var shadowViewOutlet: UIView!
    @IBOutlet weak var cardView: UIView!
    var movie: Movie?
    var canFavorite = true
    
    @IBOutlet weak var moviePosterImageViewOutlet: UIImageView!
    @IBOutlet weak var movieTitleLabelOutlet: UILabel!
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    
    override func awakeFromNib() {
        
        self.shadowViewOutlet.layer.cornerRadius = 10
        self.shadowViewOutlet.layer.shadowColor = UIColor.black.cgColor
        self.shadowViewOutlet.layer.shadowOpacity = 0.25
        self.shadowViewOutlet.layer.shadowOffset = CGSize.zero
        self.shadowViewOutlet.layer.shadowRadius = 3
        self.shadowViewOutlet.layer.masksToBounds = false
        
        self.cardView.layer.cornerRadius = 10
        self.cardView.layer.masksToBounds = true
        
    }
    
    func setupCell(movie: Movie){
        
        let imageUrl = "https://image.tmdb.org/t/p/w200"
        let imageEndpoint = imageUrl + movie.poster_path
        print(imageEndpoint)
        
        let url = URL(string: imageEndpoint)
        
        if MovieDAO.isMovieFavorite(comparedMovie: movie){
            print(movie.title)
            print("Is Favorite!")
            self.favoriteButtonOutlet.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        }else{
            print(movie.title)
            print("Is not Favorite!")
            self.favoriteButtonOutlet.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
        
        self.movie = movie
        self.moviePosterImageViewOutlet.kf.setImage(with: url)
        self.movieTitleLabelOutlet.text = movie.title
        
    }
    
    @IBAction func favoriteMovieButtonTapped(_ sender: Any) {
        
        let favoriteMovies = MovieDAO.readAllFavoriteMovies()
        
        for favoriteMovie in favoriteMovies {
            if favoriteMovie.title == self.movie?.title{
                self.canFavorite = false
            }
        }
        
        if self.canFavorite == true{
            MovieDAO.saveMovieAsFavorite(movie: self.movie!)
            self.favoriteButtonOutlet.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        } else if self.canFavorite == false{
            print("This movie has already been marked as favorite")
        }
        
    }
    
}
