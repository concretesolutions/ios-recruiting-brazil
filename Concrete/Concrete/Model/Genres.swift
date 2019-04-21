//
//  Genres.swift
//  Concrete
//
//  Created by Vinicius Brito on 21/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import Foundation

struct Genres: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
