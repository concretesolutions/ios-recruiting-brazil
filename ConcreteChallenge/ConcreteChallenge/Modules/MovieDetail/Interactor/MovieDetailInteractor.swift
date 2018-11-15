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
            
            let movieDetail = MovieDetails(movie: movie, posterImage: posterImage, genres: ["Teste Genero 1", "Teste Genero 2"])
            
            self.output.didFetchMovieDetails(movieDetails: movieDetail)
        }
    }
    
    
}
