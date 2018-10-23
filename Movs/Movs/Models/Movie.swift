//
//  Movie.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let genresId: [Int]
    let title: String
    let overview: String
    let releaseDate: Date
    let posterPath: String
}
