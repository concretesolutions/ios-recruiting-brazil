//
//  MovieDetailInteractor.swift
//  Movies
//
//  Created by Renan Germano on 24/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MovieDetailInteractor: MovieDetailUseCase {
    
    // MARK: - Properties
    
    var output: MovieDetailInteractorOutput!
    var movie: Movie!
    
    // MARK: - MovieDetailUseCase protocol functions
    
    func getMovie() {
        self.output.didGet(movie: self.movie)
    }
    
    func favorite(movie: Movie) {
        DispatchQueue.main.async {
            MovieDataManager.createFavoriteMovie(movie)
            ImageDataManager.saveImage(posterPath: movie.posterPath, image: movie.posterImage ?? UIImage())
        }
        movie.isFavorite = true
    }
    
    func unfavorite(movie: Movie) {
        DispatchQueue.main.async {
            MovieDataManager.deleteFavoriteMovie(withId: movie.id)
            ImageDataManager.deleteImage(withPosterPath: movie.posterPath)
        }
        movie.isFavorite = false
    }
    
}
