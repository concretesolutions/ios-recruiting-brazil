//
//  FavoriteCellViewModel.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
protocol FavoriteCellViewModelType {
    var title: String { get }
    var year: String { get }
    var desc: String { get }
    var imgURL: String { get }
}

final class FavoriteCellViewModel: FavoriteCellViewModelType {
    
    private var movie: MovieModel
    
    init(movie: MovieModel) {
        self.movie = movie
    }
    
    var title: String {
        return self.movie.title
    }
    
    var year: String {
        return self.movie.releaseYear
    }
    
    var desc: String {
        return self.movie.desc
    }
    
    var imgURL: String {
        return "https://image.tmdb.org/t/p/w200\(self.movie.posterPath)"
    }
}
