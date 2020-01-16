//
//  Movie.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 15/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import Foundation

class Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let genreIDs: [Int]
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case genreIDs = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
}
