//
//  Movies.swift
//  Movs
//
//  Created by Franclin Cabral on 1/19/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation

struct Movie {
    var posterPath: String?
    var adult: Bool
    var overview: String
    var releaseDate: Date
    var genreIds: [Int]
    var originalTitle: String
    var originalLanguage: String
    var title: String
    var backdropPath: String?
    var popularity: Double
    var voteCount: Int
    var video: Bool
    var voteAvarage: Double

}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case title
        case popularity
        case video
        case genreIds = "genre_ids"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case voteAvarage = "vote_average"
    }
    
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let posterPath: String? = try container.decodeIfPresent(String.self, forKey: .posterPath)
        let backdropPath: String? = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        let adult: Bool = try container.decode(Bool.self, forKey: .adult)
        let video: Bool = try container.decode(Bool.self, forKey: .video)
        let overview: String = try container.decode(String.self, forKey: .overview)
        let title: String = try container.decode(String.self, forKey: .title)
        let originalTitle: String = try container.decode(String.self, forKey: .originalTitle)
        let originalLanguage: String = try container.decode(String.self, forKey: .originalLanguage)
        let genreIds: [Int] = try container.decode([Int].self, forKey: .genreIds)
        let popularity: Double = try container.decode(Double.self, forKey: .popularity)
        let voteAvarage: Double = try container.decode(Double.self, forKey: .voteAvarage)
        let voteCount: Int = try container.decode(Int.self, forKey: .voteCount)
        
        let dateString: String = try container.decode(String.self, forKey: .releaseDate)
        let releaseDate: Date = dateString.date()
        
        self.init(posterPath: posterPath, adult: adult, overview: overview, releaseDate: releaseDate, genreIds: genreIds, originalTitle: originalTitle, originalLanguage: originalLanguage, title: title, backdropPath: backdropPath, popularity: popularity, voteCount: voteCount, video: video, voteAvarage: voteAvarage)
    }
}

