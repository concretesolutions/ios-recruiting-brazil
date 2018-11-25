//
//  PopularMovieResponse.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 12/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class PopularMoviesResponse: Decodable {
    
    // MARK: - Properties
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    
    // MARK: - Decodable Keys
    enum PopularMoviesResponseDecodableKey: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
    
    // MARK - Inits
    init(page: Int, totalResults: Int, totalPages: Int, results: [Movie]) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PopularMoviesResponseDecodableKey.self)
        
        let page: Int = try container.decode(Int.self, forKey: .page)
        let totalResults: Int = try container.decode(Int.self, forKey: .totalResults)
        let totalPages: Int = try container.decode(Int.self, forKey: .totalPages)
        let results: [Movie] = try container.decode([Movie].self, forKey: .results)
        
        
        self.init(page: page, totalResults: totalResults, totalPages: totalPages, results: results)
    }
}
