//
//  Movie.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation

class Movie: Codable {
   
    let posterPath: String
    let id: Int
    let backdropPath: String?
    let genreIDS: [Int]
    let title: String
    let overview, releaseDate: String
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case title
        case overview
        case releaseDate = "release_date"
    }
}
