//
//  TMDBResponse.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 19/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation

struct TMDBResponse {
    
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Movie]
    
}

extension TMDBResponse: Codable{
    
    enum CodingKeys: String, CodingKey{
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
