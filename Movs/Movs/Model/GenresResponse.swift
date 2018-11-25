//
//  GenreResponse.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import Foundation

struct GenresResponse {
    var genres: [Genre]
}

extension GenresResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case genres
    }
}
