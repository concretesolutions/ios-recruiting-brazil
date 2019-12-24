//
//  MovieDTO.swift
//  Movs
//
//  Created by Lucca Ferreira on 17/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation

struct MovieDTO: Decodable {
    private(set) var id: Int
    private(set) var overview: String
    private(set) var releaseDate: String
    private(set) var genreIds: [Int]
    private(set) var title: String
    private(set) var posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case title
        case posterPath = "poster_path"
    }

}
