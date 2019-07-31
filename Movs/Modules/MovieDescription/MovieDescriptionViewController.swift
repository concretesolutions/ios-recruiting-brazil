//
//  MovieDescriptionViewController.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 26/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit

class MovieDescriptionViewController: UIViewController, MovieDescriptionView {
    
    //MARK: - Outlets
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var separatorMovieTitle: UIView!
    @IBOutlet weak var separatorReleaseDate: UIView!
    @IBOutlet weak var separatorGenres: UIView!
    
    //MARK: - Contract Properties
    var presenter: MovieDescriptionPresentation!
    
    //MARK: - Properties
    var movie: MovieEntity?
    let favoriteIconHighlighted = UIImage(imageLiteralResourceName: "favorite_full_icon")
    let favoriteIconNonHighlighted = UIImage(imageLiteralResourceName: "favorite_empty_icon")
    
    //MARK: - View Start Functions
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let movie = movie {
            if UserSaves.isFavorite(movie: movie) {
                self.favoriteIcon.image = favoriteIconHighlighted
            }
            else {
                self.favoriteIcon.image = favoriteIconNonHighlighted
            }
        }
    }
    
    override func viewDidLoad() {
        adjustConstraints()
        super.viewDidLoad()
        presenter.viewDidLoad()
        self.view.backgroundColor = ColorPalette.background.uiColor

        poster.image = poster.image?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch)
        movieDescription.numberOfLines = 0
        movieDescription.sizeToFit()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didFavoriteMovie(_:)))
        favoriteIcon.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK: - Contract Functions
    func showNoContentScreen() { }
    
    func showMovieDescription(movie: MovieEntity, genres: String, poster: PosterEntity?) {
        self.movie = movie
        
        self.poster.image = poster?.poster
        self.movieTitle.text = movie.title
        self.releaseDate.text = movie.formatDateString()
        self.genres.text = genres
        self.movieDescription.text = movie.movieDescription
        if UserSaves.isFavorite(movie: movie) {
            self.favoriteIcon.image = favoriteIconHighlighted
        }
        else {
            self.favoriteIcon.image = favoriteIconNonHighlighted
        }
    }
    
    @objc func didFavoriteMovie(_ sender: UITapGestureRecognizer? = nil) {
        let tappadIcon = sender?.view as! UIImageView
        
        if tappadIcon.image == favoriteIconNonHighlighted {
        
            let alert = UIAlertController(title: nil, message: "Do you wish to favorite this movie?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
                tappadIcon.image = self.favoriteIconHighlighted
                self.presenter.didFavoriteMovie()
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
        
        else {
            self.favoriteIcon.image = self.favoriteIconNonHighlighted
            self.presenter.didFavoriteMovie()
        }
        
    }

    func adjustConstraints() {
        poster.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        genres.translatesAutoresizingMaskIntoConstraints = false
        movieDescription.translatesAutoresizingMaskIntoConstraints = false
        favoriteIcon.translatesAutoresizingMaskIntoConstraints = false
        separatorMovieTitle.translatesAutoresizingMaskIntoConstraints = false
        separatorReleaseDate.translatesAutoresizingMaskIntoConstraints = false
        separatorGenres.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Poster constraints
        if let poster = self.poster {
            self.view.addConstraints([
                NSLayoutConstraint(item: poster, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 30),
                NSLayoutConstraint(item: poster, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -30),
                NSLayoutConstraint(item: poster, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 20),
                NSLayoutConstraint(item: poster, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 220)
                ])
        }
        
        //MARK: Movie title constraints
        if let movieTitle = self.movieTitle {
            self.view.addConstraints([
                NSLayoutConstraint(item: movieTitle, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 20),
                NSLayoutConstraint(item: movieTitle, attribute: .trailing, relatedBy: .equal, toItem: favoriteIcon, attribute: .leading, multiplier: 1.0, constant: -10),
                NSLayoutConstraint(item: movieTitle, attribute: .top, relatedBy: .equal, toItem: poster, attribute: .bottom, multiplier: 1.0, constant: 20),
                NSLayoutConstraint(item: movieTitle, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30)
            ])
        }
        
        //MARK: Favorite icon constraints
        if let favoriteIcon = self.favoriteIcon {
            self.view.addConstraints([
                NSLayoutConstraint(item: favoriteIcon, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -20),
                NSLayoutConstraint(item: favoriteIcon, attribute: .centerY, relatedBy: .equal, toItem: movieTitle, attribute: .centerY, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: favoriteIcon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30),
                NSLayoutConstraint(item: favoriteIcon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 30)
                ])
        }
        
        //MARK: Separator movie title  constraints
        if let separatorMovieTitle = self.separatorMovieTitle {
            self.view.addConstraints([
                NSLayoutConstraint(item: separatorMovieTitle, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 20),
                NSLayoutConstraint(item: separatorMovieTitle, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -20),
                NSLayoutConstraint(item: separatorMovieTitle, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 1),
                NSLayoutConstraint(item: separatorMovieTitle, attribute: .top, relatedBy: .equal, toItem: movieTitle, attribute: .bottom, multiplier: 1.0, constant: 7),
                NSLayoutConstraint(item: separatorMovieTitle, attribute: .bottom, relatedBy: .equal, toItem: releaseDate, attribute: .top, multiplier: 1.0, constant: -7)
                ])
        }
        
        //MARK: Release date constraints
        if let releaseDate = self.releaseDate {
            self.view.addConstraints([
                NSLayoutConstraint(item: releaseDate, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 20),
                NSLayoutConstraint(item: releaseDate, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -20),
                NSLayoutConstraint(item: releaseDate, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30)
                ])
        }
        
        //MARK: Separator release date constraints
        if let separetorReleaseDate = self.separatorReleaseDate {
            self.view.addConstraints([
                NSLayoutConstraint(item: separetorReleaseDate, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 20),
                NSLayoutConstraint(item: separetorReleaseDate, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -20),
                NSLayoutConstraint(item: separetorReleaseDate, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 1),
                NSLayoutConstraint(item: separetorReleaseDate, attribute: .top, relatedBy: .equal, toItem: releaseDate, attribute: .bottom, multiplier: 1.0, constant: 7),
                NSLayoutConstraint(item: separetorReleaseDate, attribute: .bottom, relatedBy: .equal, toItem: genres, attribute: .top, multiplier: 1.0, constant: -7)
                ])
        }
        
        //MARK: Genres constraints
        if let genres = self.genres {
            self.view.addConstraints([
                NSLayoutConstraint(item: genres, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 20),
                NSLayoutConstraint(item: genres, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -20),
                NSLayoutConstraint(item: genres, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30)
                ])
        }
        
        //MARK: Separator genres constraints
        if let separetorGenres = self.separatorGenres {
            self.view.addConstraints([
                NSLayoutConstraint(item: separetorGenres, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 20),
                NSLayoutConstraint(item: separetorGenres, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -20),
                NSLayoutConstraint(item: separetorGenres, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 1),
                NSLayoutConstraint(item: separetorGenres, attribute: .top, relatedBy: .equal, toItem: genres, attribute: .bottom, multiplier: 1.0, constant: 7),
                NSLayoutConstraint(item: separetorGenres, attribute: .bottom, relatedBy: .equal, toItem: movieDescription, attribute: .top, multiplier: 1.0, constant: -7)
                ])
        }
        
        //MARK: Movie description constraints
        if let movieDescription = self.movieDescription {
            self.view.addConstraints([
                NSLayoutConstraint(item: movieDescription, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 20),
                NSLayoutConstraint(item: movieDescription, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: -20),
                NSLayoutConstraint(item: movieDescription, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 150)
                ])
        }
        
        self.view.updateConstraints()
        
    }
    
    
}
