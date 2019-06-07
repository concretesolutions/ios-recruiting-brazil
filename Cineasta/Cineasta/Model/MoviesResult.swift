//
//  Movie.swift
//  Cineasta
//
//  Created by Tomaz Correa on 03/06/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import Foundation

class MoviesResult: Codable {
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: [Result]?
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}

class Result: Codable {
    var movieId: Int?
    var title: String?
    var posterPath: String?
    var genreIds: [Int]?
    var backdropPath: String?
    var overview: String?
    var releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case title = "title"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case overview = "overview"
        case releaseDate = "release_date"
    }
}
