//
//  Movie.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String
    let genreIds: [Int]
    let releaseDate: String
    var isFavorite: Bool? = false
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
    }
}

extension Movie: Equatable {
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}

