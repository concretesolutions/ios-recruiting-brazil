//
//  FavoritesInteractor.swift
//  Movies
//
//  Created by Renan Germano on 23/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import Foundation

class FavoritesInteractor: FavoritesUseCase {
    
    // MARK: - Properties
    
    var output: FavoritesInteractorOutput!
    
    // MARK: - FavoriteUseCase protocol functions
    
    func readFavoriteMovies() {
        self.output.didRead(movies: MovieDataManager.readFavoriteMovies())
    }
    
    func removeFilters() {
        
    }
    
    func searchMovies(withTitle title: String) {
        self.output.didSearchMovies(withTitle: title, MovieDataManager.readFavoriteMovies().filter { return $0.title.contains(title) })
    }
    
    func unfavorite(movie: Movie) {
        MovieDataManager.deleteFavoriteMovie(withId: movie.id)
    }
    
    
    
    
}
