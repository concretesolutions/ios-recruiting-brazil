//
//  MovieId.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 25/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//


import Foundation

class MovieId: Codable {
    var id: Int32
    var title: String
    var overview: String
    var genres: [Genre]
    var posterPath: String?
    var backdropPath: String?
    var releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id, title, overview, genres
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
}
