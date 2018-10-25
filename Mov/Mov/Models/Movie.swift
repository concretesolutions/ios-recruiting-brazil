//
//  Movie.swift
//  ShitMov
//
//  Created by Miguel Nery on 23/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let releaseDate: Date
    let genres: [MovieGenre]
    let overview: String
    let posterPath: String
}
