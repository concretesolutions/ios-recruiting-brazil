//
//  MovieCellViewModel.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MovieCellViewModel {
    private(set) var movie: Movie
    
    let titleText: String
    
    var isFavorite: Bool {
        return self.movieService.isFavorite(movie: self.movie)
    }
    
    private var movieService: MovieServiceProtocol
    
    init(with movie: Movie, andService service: MovieServiceProtocol) {
        self.movie = movie
        self.titleText = movie.title
        self.movieService = service
    }
}
