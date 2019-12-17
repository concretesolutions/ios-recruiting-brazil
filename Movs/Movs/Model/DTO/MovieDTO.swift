//
//  MovieDTO.swift
//  Movs
//
//  Created by Lucca Ferreira on 17/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation

struct MovieDTO: Decodable {
    var id: Int
    var overview: String
    var releaseDate: String
    var genreIds: [Int]
    var title: String
    var posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case title
        case posterPath = "poster_path"
    }

}
