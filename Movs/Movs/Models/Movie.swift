//
//  Movie.swift
//  Movs
//
//  Created by Brendoon Ryos on 24/01/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import Foundation

class Movie: Decodable {
  var isFavorite: Bool = false
  let voteCount: Int
  let id: Int
  let video: Bool
  let voteAverage: Double
  let title: String
  let popularity: Double
  let posterPath: String?
  let originalLanguage: String
  let originalTitle: String
  let genreIds: [Int]
  let backdropPath: String?
  let adult: Bool
  let overview: String
  let releaseDate: String
  
  private enum CodingKeys: String, CodingKey {
    case voteCount = "vote_count"
    case id
    case video
    case voteAverage = "vote_average"
    case title
    case popularity
    case posterPath = "poster_path"
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case genreIds = "genre_ids"
    case backdropPath = "backdrop_path"
    case adult
    case overview
    case releaseDate = "release_date"
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    voteCount = try container.decode(Int.self, forKey: .voteCount)
    id = try container.decode(Int.self, forKey: .id)
    video  = try container.decode(Bool.self, forKey: .video)
    voteAverage = try container.decode(Double.self, forKey: .voteAverage)
    title = try container.decode(String.self, forKey: .title)
    popularity = try container.decode(Double.self, forKey: .popularity)
    posterPath = try? container.decode(String.self, forKey: .posterPath)
    originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
    originalTitle = try container.decode(String.self, forKey: .originalTitle)
    genreIds = try container.decode([Int].self, forKey: .genreIds)
    backdropPath = try? container.decode(String.self, forKey: .backdropPath)
    adult = try container.decode(Bool.self, forKey: .adult)
    overview = try container.decode(String.self, forKey: .overview)
    releaseDate = try container.decode(String.self, forKey: .releaseDate)
  }
}

extension Movie: Equatable {
  static func ==(lhs: Movie, rhs: Movie) -> Bool {
    return lhs.id == rhs.id
  }
}
