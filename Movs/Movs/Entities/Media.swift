//
//  Media.swift
//  Movs
//
//  Created by Gabriel Coutinho on 01/12/20.
//

import Foundation

struct Media: Codable {
    let posterPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: Date?
    let genreList: [Genre]?
    let id: Int?
    let originalTitle: String?
    let originalLanguage: String?
    let title: String?
    let backdropPath: String?
    let popularity: Float?
    let voteCount: Int?
    let video: Bool?
    let voteAverage: Float?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        posterPath = try values.decode(String.self, forKey: .posterPath)

        adult = try values.decode(Bool.self, forKey: .adult)

        overview = try values.decode(String.self, forKey: .overview)

        let dateString = try values.decode(String.self, forKey: .releaseDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        releaseDate = dateFormatter.date(from: dateString)

        let genreListInt = try values.decode([Int].self, forKey: .genreList)
        genreList = genreListInt.map { genre in return Genre(id: genre) }

        id = try values.decode(Int.self, forKey: .id)

        originalTitle = try values.decode(String.self, forKey: .originalTitle)

        originalLanguage = try values.decode(String.self, forKey: .originalLanguage)

        title = try values.decode(String.self, forKey: .title)

        backdropPath = try values.decode(String.self, forKey: .backdropPath)

        popularity = try values.decode(Float.self, forKey: .popularity)

        voteCount = try values.decode(Int.self, forKey: .voteCount)

        video = try values.decode(Bool.self, forKey: .video)

        voteAverage = try values.decode(Float.self, forKey: .voteAverage)
    }
    
    private enum CodingKeys: String, CodingKey {
        case adult,
             overview,
             id,
             title,
             popularity,
             video,
             posterPath = "poster_path",
             releaseDate = "release_date",
             genreList = "genre_ids",
             originalTitle = "original_title",
             originalLanguage = "original_language",
             backdropPath = "backdrop_path",
             voteCount = "vote_count",
             voteAverage = "vote_average"
    }
}
