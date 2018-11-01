//
//  Genre.swift
//  ShitMov
//
//  Created by Miguel Nery on 23/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct GenreResults: Decodable {
    let genres: [Genre]
}
