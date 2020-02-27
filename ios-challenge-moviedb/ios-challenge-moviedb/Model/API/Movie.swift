//
//  Movie.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 21/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Foundation

class Movie: Codable {
    
    var id: Int
    var title: String
    var overview: String
    var posterPath: String
    var backdropPath: String
    var releaseDate: String
    var genreIds: [Int]
    var isFavorite: Bool = false
    
    init(id: Int, title: String, overview: String, posterPath: String,
         backdropPath: String, releaseDate: String, genreIds: [Int]) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.genreIds = genreIds
    }
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
    }
}
