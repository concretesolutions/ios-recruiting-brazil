//
//  GenresResponse.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 30/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

struct GenresResponse: Codable {
    let genres: [GenreResponse]

    // MARK: - Codable conforms

    enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
}
