//
//  Movie.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation



// MARK: - Result
class Movie: Codable {
    let voteCount, id: Int?
    let video: Bool?
    let voteAverage: Double?
    let title: String?
    let popularity: Double?
    let posterPath, originalLanguage, originalTitle: String?
    let genreIDS: [Int]?
    let backdropPath: String?
    let adult: Bool?
    let overview, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id, video
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case releaseDate = "release_date"
    }
    
    init(voteCount: Int?, id: Int?, video: Bool?, voteAverage: Double?, title: String?, popularity: Double?, posterPath: String?, originalLanguage: String?, originalTitle: String?, genreIDS: [Int]?, backdropPath: String?, adult: Bool?, overview: String?, releaseDate: String?) {
        self.voteCount = voteCount
        self.id = id
        self.video = video
        self.voteAverage = voteAverage
        self.title = title
        self.popularity = popularity
        self.posterPath = posterPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIDS = genreIDS
        self.backdropPath = backdropPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
    }
}

// MARK: Result convenience initializers and mutators

extension Movie {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Movie.self, from: data)
        self.init(voteCount: me.voteCount, id: me.id, video: me.video, voteAverage: me.voteAverage, title: me.title, popularity: me.popularity, posterPath: me.posterPath, originalLanguage: me.originalLanguage, originalTitle: me.originalTitle, genreIDS: me.genreIDS, backdropPath: me.backdropPath, adult: me.adult, overview: me.overview, releaseDate: me.releaseDate)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        voteCount: Int?? = nil,
        id: Int?? = nil,
        video: Bool?? = nil,
        voteAverage: Double?? = nil,
        title: String?? = nil,
        popularity: Double?? = nil,
        posterPath: String?? = nil,
        originalLanguage: String?? = nil,
        originalTitle: String?? = nil,
        genreIDS: [Int]?? = nil,
        backdropPath: String?? = nil,
        adult: Bool?? = nil,
        overview: String?? = nil,
        releaseDate: String?? = nil
        ) -> Movie {
        return Movie(
            voteCount: voteCount ?? self.voteCount,
            id: id ?? self.id,
            video: video ?? self.video,
            voteAverage: voteAverage ?? self.voteAverage,
            title: title ?? self.title,
            popularity: popularity ?? self.popularity,
            posterPath: posterPath ?? self.posterPath,
            originalLanguage: originalLanguage ?? self.originalLanguage,
            originalTitle: originalTitle ?? self.originalTitle,
            genreIDS: genreIDS ?? self.genreIDS,
            backdropPath: backdropPath ?? self.backdropPath,
            adult: adult ?? self.adult,
            overview: overview ?? self.overview,
            releaseDate: releaseDate ?? self.releaseDate
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
