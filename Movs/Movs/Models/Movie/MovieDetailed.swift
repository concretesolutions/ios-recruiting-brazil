//
//  MovieDetailed.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

struct MovieDetailed: Decodable {
    var id: Int
    var genres: [Genre]
    var posterPath: String
    var overview: String
    var releaseDate: String
    var title: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case genres
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case title
    }
}
