//
//  PopularMovieInteractor.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class PopularMoviesInteractor: PopularMoviesInteractorInput {
    
    // MARK: - Properties
    var output: PopularMoviesInteractorOutput!
    
    // If there is an error it will try to request again
    // Max of 5 times
    var attempt = 1
    var maxAttempts = 5
    
    // MARK: - PopularMoviesInteractorInput Functions
    func fetchMovies() {
        MovieDataManager.fetchPopularMovies { (status) in
            if status == RequestStatus.success {
                // Get Favorites to check which popular movie is also a favorite
                FavoriteMovieCoreDataManager.getFavoriteMovies(completion: { (status) in
                    if status == RequestStatus.success {
                        // Compare popular and favorite movies to set the favorite flag
                        for popularMovie in MovieDataManager.movies {
                            for favoriteMovie in FavoriteMovieCoreDataManager.favoriteMovies {
                                if popularMovie.id == favoriteMovie.id {
                                    popularMovie.isFavorite = true
                                }
                            }
                        }
                        self.output.didFetch(movies: MovieDataManager.movies)
                        
                        // Reset attempt counter
                        self.attempt = 1
                    }
                })
            } else {
                if self.attempt >= self.maxAttempts {
                    self.output.didFailedToFetchMovies()
                } else {
                    // Increment Attempt and Try Again
                    self.attempt += 1
                    self.fetchMovies()
                }
            }
        }
    }
    
    func searchMovies(with text: String) {
        var filteredMovies: [Movie] = []
        
        if text.isEmpty {
            filteredMovies = MovieDataManager.movies
        } else {
            let formattedText = text.lowercased().folding(options: .diacriticInsensitive, locale: .current)
            filteredMovies = MovieDataManager.movies.filter { (movie) -> Bool in
                // Looks for matches with Movie Title ignoring case sensitive and Accents
                movie.title.lowercased().folding(options: .diacriticInsensitive, locale: .current).range(of: formattedText) != nil
            }
        }
        self.output.didSearchMovies(filteredMovies: filteredMovies)
    }
}
