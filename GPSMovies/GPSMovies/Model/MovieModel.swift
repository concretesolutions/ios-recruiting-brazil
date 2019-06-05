//
//  MovieModel.swift
//  GPSMovies
//
//  Created by Gilson Santos on 02/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import Foundation

class MovieModel : Codable {
    var page : Int?
    var totalResults : Int?
    var totalPages : Int?
    var results : [MovieElementModel]?
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}

class MovieElementModel : Codable {
    var voteCount : Int?
    var id : Int64?
    var video : Bool?
    var voteAverage : Double?
    var title : String?
    var popularity : Double?
    var posterPath : String?
    var originalLanguage : String?
    var originalTitle : String?
    var genreIds : [Int]?
    var backdropPath : String?
    var adult : Bool?
    var overview : String?
    var releaseDate : String?
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id = "id"
        case video = "video"
        case voteAverage = "vote_average"
        case title = "title"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
    }
}

