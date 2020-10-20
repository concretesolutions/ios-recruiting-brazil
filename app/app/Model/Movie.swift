//
//  Movie.swift
//  app
//
//  Created by rfl3 on 19/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import Foundation

struct Movie: Codable {

    var backdropPath: String?
    var posterPath: String?
    var overview: String?
    var releaseDate: Date?
    var genreIds: [Int]?
    var id: Int?
    var title: String?

    enum CodingKeys: String, CodingKey {
        case overview, id, title
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
    }

}
