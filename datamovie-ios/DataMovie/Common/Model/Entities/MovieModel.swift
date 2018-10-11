//
//  MovieModel.swift
//  DataMovie
//
//  Created by Andre on 14/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

struct SpokenLanguage: Decodable {
    var iso_639_1: String
    var name: String
}

struct MovieModel: Decodable {
    
    var tmdbID: Int?
    var imdbID: String?
    var title: String?
    var originalTitle: String?
    var originalLanguage: String?
    var spokenLanguage: [SpokenLanguage]?
    var overview: String?
    var posterPath: String?
    var budget: Double?
    var revenue: Double?
    var homepage: String?
    var isAdult: Bool?
    var releaseDate: String?
    var runtime: Int?
    var status: String?
    var voteAverage: Float?
    var genres: [GenreModel]?
    var credits: CreditsModel?
    var videos: [VideoModel]?
    
    enum CodingKeys: String, CodingKey {
        case tmdbID             = "id"
        case imdbID             = "imdb_id"
        case title              = "title"
        case originalTitle      = "original_title"
        case originalLanguage   = "original_language"
        case spokenLanguage     = "spoken_languages"
        case overview           = "overview"
        case posterPath         = "poster_path"
        case budget             = "budget"
        case revenue            = "revenue"
        case homepage           = "homepage"
        case isAdult            = "adult"
        case releaseDate        = "release_date"
        case runtime            = "runtime"
        case status             = "status"
        case voteAverage        = "vote_average"
        case genres             = "genres"
        case videos             = "videos"
        case credits            = "credits"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tmdbID = try container.decodeIfPresent(Int.self, forKey: .tmdbID)
        imdbID = try container.decodeIfPresent(String.self, forKey: .imdbID)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        spokenLanguage = try container.decodeIfPresent([SpokenLanguage].self, forKey: .spokenLanguage)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        budget = try container.decodeIfPresent(Double.self, forKey: .budget)
        revenue = try container.decodeIfPresent(Double.self, forKey: .revenue)
        homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        isAdult = try container.decodeIfPresent(Bool.self, forKey: .isAdult) ?? false
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        voteAverage = try container.decodeIfPresent(Float.self, forKey: .voteAverage)
        genres = try container.decodeIfPresent([GenreModel].self, forKey: .genres)
        credits = try container.decodeIfPresent(CreditsModel.self, forKey: .credits)
        if let videosResult = try container.decodeIfPresent([String:[VideoModel]].self, forKey: .videos),
            let videos = videosResult[VideoModel.CodingKeys.results.stringValue] {
             self.videos = videos
        }
    }

}
