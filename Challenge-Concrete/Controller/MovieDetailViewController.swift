//
//  MovieDetailViewController.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    let movieDetailView: MovieDetailView
    var movie: Movie!
    var favoriteMovie: FavoriteMovie!
    
    weak var favoriteMovieDelegate: FavoriteMovieDelegate?
    init(with movie: Movie) {
        self.movie = movie
        movieDetailView = MovieDetailView(with: movie)
        super.init(nibName: nil, bundle: nil)
    }
    
    init(with favoriteMovie: FavoriteMovie) {
        self.favoriteMovie = favoriteMovie
        movieDetailView = MovieDetailView(with: favoriteMovie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailView.favoriteAction = favoriteAction(_:)
    }
    
    func favoriteAction(_ isFavorite: Bool) {
        if let movie = movie {
            self.favoriteMovieDelegate?.didToggle(movie)
        } else if let favoriteMovie = favoriteMovie {
            self.favoriteMovieDelegate?.didToggle(favoriteMovie)
        }
    }
    
    override func loadView() {
        view = movieDetailView
    }
}
