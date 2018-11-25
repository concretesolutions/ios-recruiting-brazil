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
        let movies = MovieDataManager.readFavoriteMovies()
        movies.forEach { $0.posterImage = ImageDataManager.readImage(withPosterPath: $0.posterPath) }
        self.output.didRead(movies: movies)
    }
    
    func removeFilters() {
        
    }
    
    func searchMovies(withTitle title: String) {
        let clearSearchText = title.trimmingCharacters(in: CharacterSet(charactersIn: " ")).lowercased()
        let movies = MovieDataManager.readFavoriteMovies()
        movies.forEach { $0.posterImage = ImageDataManager.readImage(withPosterPath: $0.posterPath) }
        let searchedMovies = movies.filter { movie in
            let clearTitle = movie.title.trimmingCharacters(in: CharacterSet(charactersIn: " ")).lowercased()
            return clearTitle.contains(clearSearchText)
        }
        self.output.didSearchMovies(withTitle: title, searchedMovies)
    }
    
    func unfavorite(movie: Movie) {
        MovieDataManager.deleteFavoriteMovie(withId: movie.id)
        ImageDataManager.deleteImage(withPosterPath: movie.posterPath)
    }
    
}
