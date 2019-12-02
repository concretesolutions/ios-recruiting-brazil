//
//  MoviesRequestDTO.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import Foundation

struct MoviesRequestDTO: Codable {
    let page: Int
    let movies: [MovieDTO]
    let totalResults, totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
