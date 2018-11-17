//
//  Genre.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 17/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import Foundation

struct Genres: Codable {
    let genres: [Genre]?
    private enum CodingKeys: String, CodingKey {
        case genres
    }
}

struct Genre: Codable {
    let id: Int?
    let name: String?
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
