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
                    }
                })
            } else {
                self.output.didFailedToFetchMovies()
            }
        }
    }
}
