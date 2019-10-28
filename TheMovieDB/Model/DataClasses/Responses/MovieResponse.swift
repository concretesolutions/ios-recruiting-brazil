//
//  MovieResponse.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 27/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

struct MovieResponse: Codable {
    
    var id: Int?
    var popularity: Float?
    var voteCount: Int?
    var video: Bool?
    var posterPath: String?
    var backdropPath: String?
    var adult: Bool?
    var originalLanguage: String?
    var originalTitle: String?
    var genreIds: [Int]?
    var title: String?
    var voteAverage: Float?
    var overview: String?
    var releaseDate: String?
    var isFavorited = false
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case popularity = "popularity"
        case voteCount = "vote_count"
        case video = "video"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case adult = "adult"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case title = "title"
        case voteAverage = "vote_average"
        case overview = "overview"
        case releaseDate = "release_date"
    }
}
