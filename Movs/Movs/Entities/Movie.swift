//
//  Movie.swift
//  Movs
//
//  Created by Dielson Sales on 01/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class Movie: Decodable {
    var movieId: Int = -1
    var title = ""
    var releaseDate = ""
    var overview = ""
    var posterPath = ""
    var isFavorited = false
    var genreIds = [Int]()

    // Transient variables
    var genres = [String]()

//    init() { }

    enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case title
        case releaseDate = "release_date"
        case overview
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
    }
}
