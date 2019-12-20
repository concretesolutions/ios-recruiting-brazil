//
//  MovieDTO.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import Foundation

struct MovieDTO: Codable, Equatable {
    let id: Int
    let title: String?
    let releaseDate: String?
    let synopsis: String?
    let posterPath: String?
    let genreIDs: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case releaseDate = "release_date"
        case synopsis = "overview"
        case posterPath = "poster_path"
        case genreIDs = "genre_ids"
    }
}
