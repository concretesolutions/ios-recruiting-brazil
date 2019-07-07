//
//  PopularMoviesCollectionViewCell.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 13/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import UIKit

class PopularMoviesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - PROPERTIES
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameOfMovieLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIImageView!
    let indicatorOfActivity = UIActivityIndicatorView()
    var favoritesMiddle: FavoriteMoviesMiddle!
    
    //MARK: - SUPER METHODS
    
    override func prepareForReuse() {
        configure(with: .none, searchData: .none)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addActivityIndicator()
        
        favoritesMiddle = FavoriteMoviesMiddle(delegate: self)
    }
    
    //MARK: - Actions
    
    @IBAction func saveAsFavorite(_ sender: Any) {
        
    }
    
    
    //MARK: - METHODS
    
    func addActivityIndicator() {
        self.posterImage.addSubview(indicatorOfActivity)
        indicatorOfActivity.translatesAutoresizingMaskIntoConstraints = false
        indicatorOfActivity.isHidden = false
        self.indicatorOfActivity.color = .white
        indicatorOfActivity.centerXAnchor.constraint(equalTo: self.posterImage.centerXAnchor).isActive = true
        indicatorOfActivity.centerYAnchor.constraint(equalTo: self.posterImage.centerYAnchor).isActive = true
        indicatorOfActivity.startAnimating()
    }
    
    func configure(with movie: PopularResults?, searchData: ResultsOfSearchWorker?) {
        posterImage.image = nil
        self.addActivityIndicator()
        if let movie = movie {
            nameOfMovieLabel.text = movie.title
            nameOfMovieLabel.textColor = Colors.darkYellow.color
            nameOfMovieLabel.alpha = 1
            posterImage.loadImageFromURLString(urlStirng: movie.poster_path)
            favoritesMiddle.favoriteMovies.filteringData(movieID: movie.id)
            let fetchedObjects = favoritesMiddle.favoriteMovies.fetchedResultsController.fetchedObjects ?? []
            if fetchedObjects.isEmpty == true {
                favoriteButton.image = UIImage(named: "favorite_gray_icon")
            } else {
                favoriteButton.image = UIImage(named: "favorite_full_icon")
            }
            self.indicatorOfActivity.removeFromSuperview()
        } else if let searchData = searchData {
            nameOfMovieLabel.text = searchData.title
            nameOfMovieLabel.textColor = Colors.darkYellow.color
            nameOfMovieLabel.alpha = 1
            posterImage.loadImageFromURLString(urlStirng: searchData.poster_path)
            favoritesMiddle.favoriteMovies.filteringData(movieID: searchData.id)
            let fetchedObjects = favoritesMiddle.favoriteMovies.fetchedResultsController.fetchedObjects ?? []
            if fetchedObjects.isEmpty == true {
                favoriteButton.image = UIImage(named: "favorite_gray_icon")
            } else {
                favoriteButton.image = UIImage(named: "favorite_full_icon")
            }
            self.indicatorOfActivity.removeFromSuperview()
        } else {
            nameOfMovieLabel.alpha = 1
            posterImage.alpha = 1
            self.addActivityIndicator()
        }
    }
}

extension PopularMoviesCollectionViewCell: FavoriteMoviesMiddleDelegate {
    
    func favoritesFetched() {
        
    }
    
    func savedMovie() {
        
    }
    
    func deletedMovie() {
        
    }
}
