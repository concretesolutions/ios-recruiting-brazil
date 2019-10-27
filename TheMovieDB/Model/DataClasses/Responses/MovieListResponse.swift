//
//  MovieListResponse.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 27/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

struct MovieListResponse: Codable {
    
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: [MovieResponse]?
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}
