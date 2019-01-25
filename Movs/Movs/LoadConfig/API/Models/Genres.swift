//
//  Genres.swift
//  Movs
//
//  Created by Filipe Jordão on 24/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation

struct GenresResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let identifier: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
    }
}
