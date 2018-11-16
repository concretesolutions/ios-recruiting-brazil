//
//  MovieDetailMiddle.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 15/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailMiddleDelegate: class {
    func didSaveMovie()
    func didRemoveMovie()
}

class MovieDetailMiddle {
    
    weak var delegate: MovieDetailMiddleDelegate?
    var movieToLoad: MovieDetailWorker!
    let favoriteMovie = FavoriteMovies()
    var favoriteToBeSavedOrDeleted: Favorite!
    var favoriteMoviesMiddle: FavoriteMoviesMiddle!
    var indexOfMovie: Int!
    
    init(delegate: MovieDetailMiddleDelegate) {
        self.delegate = delegate
    }
    
    func fetchMovies() {
        favoriteMovie.fetch()
    }
    
    func savedMovie(movie: MovieDetailWorker) {
        favoriteToBeSavedOrDeleted = Favorite(title: movie.title, description: movie.description, posterPath: movie.posterPath, isFavorite: movie.isFavorite, genreID: movie.genreID, yearOfRelease: movie.yearOfRelease, id: movie.id)
        favoriteMovie.savingFavorite(movie: favoriteToBeSavedOrDeleted)
        NotificationCenter.default.post(name: .didReceiveData, object: nil)
        delegate?.didSaveMovie()
        print("salvou")
    }
    
    func removeFavorite(movie: FavoriteMovies) {
        favoriteMovie.removeFavorite(movie: movie)
        delegate?.didRemoveMovie()
    }
}
