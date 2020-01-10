//
//  Movie.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 09/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation

public struct Movie: Decodable {
    let popularity, voteAverage: Double
    let id, voteCount: Int
    let title, posterPath, overview, releaseDate, backdropPath, originalLanguage, originalTitle: String
    let adult, video: Bool
    let genres: [Int]

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genres = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
