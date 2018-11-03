//
//  ManageFavoriteMoviesActions.swift
//  Movs
//
//  Created by Maisa on 28/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

protocol ManageFavoriteMoviesActions {
    func addFavoriteMovie(movie: MovieDetailed) -> Bool
    func removeFavoriteMovie(id: Int) -> Bool
    func getFavoriteMovies() -> [MovieDetailed]
    func findMovieWith(id: Int) -> Bool
}

// For Interactors
protocol FavoriteActionBusinessLogic {
    func addFavorite(movie: MovieDetailed)
    func removeFavorite(movie: MovieDetailed)
}

// For Presenter
protocol FavoriteActionsPresentationLogic {
    func favoriteActionSuccess(message: String)
    func favoriteRemove(message: String)
    func favoriteActionError(message: String)
}
