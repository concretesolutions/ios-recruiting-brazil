//
//  MovieGridMovie.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

struct MovieGridUnit {
    let title: String
    let posterPath: String
    let isFavorite: Bool
    
    init(title: String, posterPath: String, isFavorite: Bool) {
        self.title = title
        self.posterPath = posterPath
        self.isFavorite = isFavorite
    }
    
    init(from movie: Movie, isFavorite: Bool) {
        self.init(title: movie.title, posterPath: movie.posterPath, isFavorite: isFavorite)
    }
}

extension MovieGridUnit: Equatable {
    static func == (lhs: MovieGridUnit, rhs: MovieGridUnit) -> Bool {
        return lhs.title == rhs.title
            && lhs.isFavorite == rhs.isFavorite
    }
}
