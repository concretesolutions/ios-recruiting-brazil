//
//  FavoriteMovieInteractor.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class FavoriteMoviesInteractor: FavoriteMoviesInteractorInput {
    
    // MARK: - Properties
    var output: FavoriteMoviesInteractorOutput!
    
    // MARK: - FavoriteMoviesInteractorInput functions
    func getFavoriteMovies() {
        FavoriteMovieCoreDataManager.getFavoriteMovies { (status) in
            if status == RequestStatus.success {
                self.output.didGetFavoriteMovies(favoriteMovies: FavoriteMovieCoreDataManager.favoriteMovies)
            }
        }
    }
    
    func removeFavoriteMovie(at indexPath: IndexPath) {
        // Update Popular Movies Array
        if let popularMovie = MovieDataManager.movies.first(where: { (movie) -> Bool in
            movie.id == FavoriteMovieCoreDataManager.favoriteMovies[indexPath.item].id
        }) {
            popularMovie.isFavorite = false
        }
        
        // Remove Movie from Favorites
        FavoriteMovieCoreDataManager.removeFavoriteMovie(at: indexPath) { (status) in
        }
    }
}
