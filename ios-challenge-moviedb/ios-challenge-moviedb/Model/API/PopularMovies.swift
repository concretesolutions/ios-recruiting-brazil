//
//  PopularMoviesResponse.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 22/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Foundation

/**
Model Popular Movies request result
 */
class PopularMovies: Codable {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var movies: [Movie]
}

extension PopularMovies {
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}
