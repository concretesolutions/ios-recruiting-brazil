//
//  MovieDetailDTO.swift
//  movs
//
//  Created by Emerson Victor on 11/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import Foundation

struct MovieDetailDTO: Codable, Equatable {
    let id: Int
    let title: String?
    let releaseDate: String?
    let synopsis: String?
    let posterPath: String?
    let genres: [GenreDTO]?
    
    enum CodingKeys: String, CodingKey {
        case id, title, genres
        case releaseDate = "release_date"
        case synopsis = "overview"
        case posterPath = "poster_path"
    }
}
