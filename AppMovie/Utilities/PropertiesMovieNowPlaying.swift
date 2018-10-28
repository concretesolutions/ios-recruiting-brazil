//
//  PropertiesMoviesNowPlaying.swift
//  AppMovie
//
//  Created by Renan Alves on 22/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import Foundation

enum PropertiesMovieNowPlaying  {
    case adult, backdropPath, genre, id, language, originalTitle, overview, popularity, posterPath, releaseDate, title, video, voteAverage, voteCount
    
    var value: String {
        switch self {
        case  .adult:
            return "adult"
        case .backdropPath:
            return "backdrop_path"
        case .genre:
            return "genre"
        case .id:
            return "id"
        case .language:
            return "language"
        case .originalTitle:
            return "original_title"
        case .overview:
            return "overview"
        case .popularity:
            return "popularity"
        case .posterPath:
            return "poster_path"
        case .releaseDate:
            return "release_date"
        case .title:
            return "title"
        case .video:
            return "video"
        case .voteAverage:
            return "vote_average"
        case .voteCount:
            return "vote_count"
        }
    }
}
    
//struct MovieNowPlaying {
//    private var adult: Bool
//    private var backdropPath: String
//    private var genre: Int
//    private var id: Int
//    private var language: String
//    private var originalTitle: String
//    private var overview: String
//    private var popularity: Decimal
//    private var posterPath: String
//    private var releaseDate: Date
//    private var title: String
//    private var video: Bool
//    private var voteAverage: String
//    private var voteCount: Int
//}


