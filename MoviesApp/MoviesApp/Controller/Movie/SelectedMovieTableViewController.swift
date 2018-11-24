//
//  SelectedMovieTableViewController.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 12/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit
import Kingfisher

class SelectedMovieTableViewController: UITableViewController {
    
    //Outlets
    @IBOutlet weak var movieImageOutlet: UIImageView!
    @IBOutlet weak var moviePosterOutlet: UIImageView!
    @IBOutlet weak var movieTitleOutlet: UILabel!
    @IBOutlet weak var movieReleaseDateOutlet: UILabel!
    @IBOutlet weak var movieGenreOutlet: UILabel!
    @IBOutlet weak var movieOverviewOutlet: UITextView!
    @IBOutlet weak var isFavoriteButton: UIButton!
    
    //Variables and Constants
    var movie: Movie?
    var genres = [Genre]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieDAO.getGenres { (response, error) in
            if error == nil{
            
                if let genres = response as? Genres{
                    for genre in genres.genres{
                        self.genres.append(genre)
                    }
                }
                
            }else{
                print("Error")
            }
            var genresString: String = ""
            
            for genre in (self.movie?.genre_ids)! {
                
                for genreUnit in self.genres{
                    if genre == genreUnit.id {
                        
                        if genresString == ""{
                            genresString += genreUnit.name
                        }else{
                            genresString += "," + genreUnit.name
                        }
                        
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.movieGenreOutlet.text = genresString
            }
        }
        
        if MovieDAO.isMovieFavorite(comparedMovie: self.movie!){
            self.isFavoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        }
        
        if let title = self.movie?.title {
            self.movieTitleOutlet.text = title
        }
        if let releaseDate = self.movie?.release_date {
            var parts = releaseDate.components(separatedBy: "-")
            self.movieReleaseDateOutlet.text = parts[0]
        }
        if let overview = self.movie?.overview {
            self.movieOverviewOutlet.text = overview
        }
        let imageUrl = "https://image.tmdb.org/t/p/w500"
        let imageEndpoint = imageUrl + (movie?.poster_path)!
        print(imageEndpoint)
        if let url = URL(string: imageEndpoint) {
            self.movieImageOutlet.kf.setImage(with: url)
            self.moviePosterOutlet.kf.setImage(with: url)
        }
    }
    
    @IBAction func isFavoriteButtonTapped(_ sender: Any) {
        
        if MovieDAO.isMovieFavorite(comparedMovie: self.movie!){
            
            MovieDAO.deleteFavoriteMovie(favoriteMovie: self.movie!)
            self.isFavoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
            
        }else{
            
            MovieDAO.saveMovieAsFavorite(movie: self.movie!)
            self.isFavoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            
        }
    }
}
