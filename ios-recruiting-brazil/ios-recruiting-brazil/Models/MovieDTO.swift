//
//  Movie.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import Foundation
struct MovieDTO: Codable {
    let title: String
    let overview: String
    let poster: String
    let releaseDate: String
    let genreIDs: [Int]

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case overview = "overview"
        case poster = "poster_path"
        case releaseDate = "release_date"
        case genreIDs = "genre_ids"
    }
}
