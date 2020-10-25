//
//  MoviesPopulariesResponse.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

struct MoviesPopulariesResponse: Codable {
    let page: Int
    let totalPages: Int
    let movies: [Movie]

    // MARK: - Codable conforms

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalPages = "total_pages"
        case movies = "results"
    }
}
