//
//  GenreListResponse.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

struct GenreListResponse: Codable {

    let genres: [Genre]
}

extension GenreListResponse {
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
}
