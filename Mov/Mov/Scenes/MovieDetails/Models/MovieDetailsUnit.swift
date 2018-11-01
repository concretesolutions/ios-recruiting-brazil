//
//  MovieDetailsUnit.swift
//  Mov
//
//  Created by Miguel Nery on 01/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation


struct MovieDetailsUnit {
    var title: String
    var posterPath: String
    var isFavorite: Bool
    var releaseDate: Date
    var genres: [String]
    var overview: String
    
    init(title: String, posterPath: String, isFavorite: Bool, releaseDate: Date, genres: [String], overview: String) {
        self.title = title
        self.posterPath = posterPath
        self.isFavorite = isFavorite
        self.releaseDate = releaseDate
        self.genres = genres
        self.overview = overview
    }
    
    init(fromMovie movie: Movie, isFavorite: Bool, genres: [String]) {
        self.init(title: movie.title, posterPath: movie.posterPath, isFavorite: isFavorite, releaseDate: movie.releaseDate, genres: genres, overview: movie.overview)
    }
}
