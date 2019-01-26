//
//  MovieAPI.swift
//  Movs
//
//  Created by Filipe Jordão on 22/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let identifier: Int
    let title: String
    let posterPath: String?
    let genreIDS: [Int]
    let overview, releaseDate: String

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case overview
        case releaseDate = "release_date"
    }
}
