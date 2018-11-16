//
//  MoviesResponse.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import Foundation

struct MoviesResponse {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Movie]
}

extension MoviesResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
}
