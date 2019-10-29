//
//  Genre.swift
//  Movs
//
//  Created by Bruno Barbosa on 28/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

class Genre: Codable {
    let id: Int
    let name: String
}

class GenreResponse: Codable {
    let genres: [Genre]
}
