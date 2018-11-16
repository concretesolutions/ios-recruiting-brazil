//
//  MovieDetails.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 15/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class MovieDetails: Movie {
    var posterImage: UIImage
    var genres: [String]
    
    // MARK: - Inits
    init(movie: Movie, posterImage: UIImage, genres: [String]) {
        self.posterImage = posterImage
        self.genres = genres
        super.init(id: movie.id, title: movie.title, posterPath: movie.posterPath, genreIds: movie.genreIds, overview: movie.overview, releaseDate: movie.releaseDate)
        
    }
    
    required convenience init(from decoder: Decoder) {
        self.init(from: decoder)
    }
}
