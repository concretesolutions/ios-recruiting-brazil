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
        ImageDataManager.getImageFrom(imagePath: movie.posterPath) { (image) in
            posterImage = image
            
            // Get Genres
            var genres: [String] = []
            MovieDataManager.fetchGenres {
                for id in movie.genreIds {
                    if let genre = MovieDataManager.genres.first(where: { $0.id == id }) {
                        genres.append(genre.name)
                    }
                }
                
                // Instantiate new Movie Detail
                let movieDetail = MovieDetails(movie: movie, posterImage: posterImage, genres: genres)
                self.output.didFetchMovieDetails(movieDetails: movieDetail)
            }
            
        }
        
        
    }
    
    
}
