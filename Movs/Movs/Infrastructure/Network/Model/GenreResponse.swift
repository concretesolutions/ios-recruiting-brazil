//
//  GenreResponse.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation

struct GenreResponse {
    var genres: [Genre]
}

extension GenreResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case genres
    }
}
