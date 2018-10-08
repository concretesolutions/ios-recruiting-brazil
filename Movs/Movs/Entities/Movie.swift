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

    var year: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: releaseDate) {
            return Calendar.current.dateComponents([.year], from: date).year ?? 0
        }
        return 0
    }

    enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case title
        case releaseDate = "release_date"
        case overview
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
    }
}
