//
//  TMDBResponse.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation

struct TMDBResponse {

    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Movie]

}

extension TMDBResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
