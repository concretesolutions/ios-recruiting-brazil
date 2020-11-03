//
//  MoviesPopulariesResponse.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

struct MoviesPopulariesResponse: Codable {
    let page: Int
    let totalPages: Int
    let moviesResponse: [MovieResponse]

    // MARK: - Codable conforms

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalPages = "total_pages"
        case moviesResponse = "results"
    }
}
