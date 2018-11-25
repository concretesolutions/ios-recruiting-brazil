//
//  PopularMovieInteractor.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class MovieDetailInteractor: MovieDetailInteractorInput {
    
    // MARK: - Properties
    var output: MovieDetailInteractorOutput!
    
    // MARK: - MovieDetailInteractorInput Functions
    func fetchMovieDetails(movie: Movie) {
        
        // Get poster imagem
        var posterImage: UIImage = UIImage()
        if let image = movie.image {
            posterImage = image
        }
        
        // Get Genres
        var genres: [String] = []
        MovieDataManager.fetchGenres(completion: { (status) in
            if status == RequestStatus.success {
                for id in movie.genreIds {
                    if let genre = MovieDataManager.genres.first(where: { $0.id == id }) {
                        genres.append(genre.name)
                    }
                }
                
                // Instantiate new Movie Detail
                let movieDetail = MovieDetails(movie: movie, posterImage: posterImage, genres: genres)
                if movie.isFavorite {
                    movieDetail.isFavorite = true
                }
                self.output.didFetchMovieDetails(movieDetails: movieDetail)
            }
        })
    }
    
    func addMovieToFavorite(movie: Movie) {
        FavoriteMovieCoreDataManager.saveFavoriteMovie(movie: movie) { (status) in
            if status == RequestStatus.success {
                self.output.didAddMovieToFavorite()
            } else {
                self.addMovieToFavorite(movie: movie)
            }
        }
    }
}
