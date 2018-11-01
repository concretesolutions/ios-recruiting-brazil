//
//  FavoritesUnit.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

struct FavoritesUnit {
    var posterPath: String
    var title: String
    var releaseDate: Date
    var overview: String
    
    init(posterPath: String, title: String, releaseDate: Date, overview: String) {
        self.posterPath = posterPath
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
    }
    
    
    init(from movie: Movie) {
        self.init(posterPath: movie.posterPath, title: movie.title, releaseDate: movie.releaseDate, overview: movie.overview)
    }
}
