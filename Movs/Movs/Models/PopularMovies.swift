//
//  PopularMovies.swift
//  Movs
//
//  Created by Franclin Cabral on 1/19/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation

struct PopularMovies {
    var page: Int
    var results: [Movie]
    var totalResults: Int
    var totalPages: Int
}

extension PopularMovies: Decodable {
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let page: Int = try container.decode(Int.self, forKey: .page)
        let totalResults: Int = try container.decode(Int.self, forKey: .totalResults)
        let totalPages: Int = try container.decode(Int.self, forKey: .totalPages)
        let results: [Movie] = try container.decode([Movie].self, forKey: .results)
        
        self.init(page: page, results: results, totalResults: totalResults, totalPages: totalPages)
    }
}
