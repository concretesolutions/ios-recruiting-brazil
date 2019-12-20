//
//  MovieDTO.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

struct MovieDTO: Decodable, Equatable {
    
    // MARK: - Attributes
    
    let id: Int
    let backdropPath: String?
    let genreIDS: [Int]?
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let overview: String?

    // MARK: - Enums
    
    enum CodingKeys: String, CodingKey {
        case id
        case popularity
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case releaseDate = "release_date"
        case title
        case overview
    }
}
