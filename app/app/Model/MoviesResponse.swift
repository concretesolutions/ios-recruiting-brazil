//
//  MoviesResponse.swift
//  app
//
//  Created by rfl3 on 23/12/19.
//  Copyright © 2019 Renan Freitas. All rights reserved.
//

import Foundation

struct MoviesResponse {
    var page: Int
    var results: [Movie]
    var totalPages: Int
    var totalResults: Int
}

extension MoviesResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
