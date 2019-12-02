//
//  Movie.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let releaseDate: String
    let description: String
    let posterPath: String
    let genres: [Genre]
}
