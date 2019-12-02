//
//  MovieDTO.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import Foundation

struct MovieDTO: Codable {
    let id: Int
    let title: String
    let releaseDate: String
    let description: String
    let posterPath: String
    let genreIDS: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case releaseDate = "release_date"
        case description = "overview"
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
    }
}
