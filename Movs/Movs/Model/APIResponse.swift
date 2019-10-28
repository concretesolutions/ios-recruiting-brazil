//
//  APIResponse.swift
//  Movs
//
//  Created by Bruno Barbosa on 28/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

struct APIResponse: Codable {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
