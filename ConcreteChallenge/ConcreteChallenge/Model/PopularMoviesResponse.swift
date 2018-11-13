//
//  PopularMovieResponse.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 12/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class PopularMoviesResponse: Codable {
    
    // MARK: - Properties
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    
    // MARK: - Decodable Keys
    enum PopularMovieResponseDecodableKey: String, CodingKey {
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
        let container = try decoder.container(keyedBy: MovieDecodableKey.self)
        
        let id: Int = try container.decode(Int.self, forKey: .id)
        let title: String = try container.decode(String.self, forKey: .id)
        let posterPath: String = try container.decode(String.self, forKey: .posterPath)
        let genreIds: [Int] = try container.decode([Int].self, forKey: .genreIds)
        let overview: String = try container.decode(String.self, forKey: .overview)
        let releaseDate: Date = try container.decode(Date.self, forKey: .releaseDate)
        
        self.init(id: id, title: title, posterPath: posterPath, genreIds: genreIds, overview: overview, releaseDate: releaseDate)
    }
    
}
