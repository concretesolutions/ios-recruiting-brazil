//
//  Movie.swift
//  ShitMov
//
//  Created by Miguel Nery on 23/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

struct Movie: Codable, Hashable {
    let id: Int
    let genreIds: [Int]
    let title: String
    let overview: String
    let releaseDate: Date
    let posterPath: String
}

struct MoviesResults: Codable {
    let results: [Movie]
}
