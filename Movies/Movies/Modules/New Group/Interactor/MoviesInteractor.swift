//
//  MoviesInteractor.swift
//  Movies
//
//  Created by Renan Germano on 20/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MoviesInteractor: MoviesUseCase {
    
    
    // MARK: - Properties
    
    var output: MoviesInteractorOutput!
    private var current: [Movie] = []
    
    // MARK: - MoviesUseCase protocol functions
    
    func getMovies(fromPage page: Int) {
        APIDataManager.readPopular(fromPage: page) { movies, error in
            if let error = error {
                
            }
            self.current.append(contentsOf: movies)
            self.output.didGetMovies(fromPage: page, movies)
        }
    }
    
    func getCurrentMovies() {
        self.output.didGetCurrentMovies(self.current)
    }
    
    func searchMovies(withTitle title: String) {
        APIDataManager.searchMovies(withTitle: title) { movies, error in
            if let error = error {
                
            }
            self.output.didSearchMovies(withTitle: title, movies)
        }
    }
    
    func favorite(movie: Movie) {
        DispatchQueue.main.async {
            MovieDataManager.createFavoriteMovie(movie)
            ImageDataManager.saveImage(posterPath: movie.posterPath ?? "", image: movie.posterImage ?? UIImage())
        }
        movie.isFavorite = true
    }
    
    func unfavorite(movie: Movie) {
        DispatchQueue.main.async {
            MovieDataManager.deleteFavoriteMovie(withId: movie.id)
            ImageDataManager.deleteImage(withPosterPath: movie.posterPath ?? "")
        }
        movie.isFavorite = false
    }
    
}
