//
//  GenresDTO.swift
//  movs
//
//  Created by Emerson Victor on 03/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import Foundation

struct GenresDTO: Codable, Equatable {
    let genres: [GenreDTO]
}

struct GenreDTO: Codable, Equatable {
    let id: Int
    let name: String
}
