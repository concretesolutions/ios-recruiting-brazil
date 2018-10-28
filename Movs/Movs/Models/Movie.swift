//
//  Movie.swift
//  Movs
//
//  Created by Ricardo Rachaus on 26/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation
import CoreData

struct Movie: Decodable {
    var id: Int
    var genreIds: [Int]
    var posterPath: String
    var overview: String
    var releaseDate: String
    var title: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case title
    }
}
