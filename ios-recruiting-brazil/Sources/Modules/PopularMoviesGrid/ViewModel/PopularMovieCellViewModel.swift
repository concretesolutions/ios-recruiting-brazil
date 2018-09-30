//
//  PopularMovieCellViewModel.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation

protocol PopularMoviesCellViewModelType {
    var title: String { get }
    var imgUrl: String { get }
}

final class PopularMoviesCellViewModel: PopularMoviesCellViewModelType {
    
    // MARK: Private Variables
    private var movie: MovieModel
    
    var title: String {
        return self.movie.title
    }
    
    var imgUrl: String {
        return "https://image.tmdb.org/t/p/w200\(movie.posterPath)"
    }
    
    init(movie: MovieModel) {
        self.movie = movie
    }
    
}
