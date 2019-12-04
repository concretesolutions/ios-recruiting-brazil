//
//  MovieDTO.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//
// swiftlint:disable identifier_name

import Foundation

struct MovieDTO: Codable, Equatable {
    let id: Int
    let title: String
    let releaseDate: String
    let synopsis: String
    let posterPath: String?
    let genreIDS: [Int]

    enum CodingKeys: String, CodingKey {
        case id, title
        case releaseDate = "release_date"
        case synopsis = "overview"
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
    }
}
