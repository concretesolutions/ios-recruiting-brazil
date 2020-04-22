//
//  Movie.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 19/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import Foundation

struct Movie: Codable, Equatable {
    var id: Int
    var title: String
    var releaseDate: Date
    var overview: String
    var genreIds: [Int]
    var posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case relaseDate = "release_date"
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.releaseDate = try values.decode(String.self, forKey: .relaseDate).dateFromText() ?? Date()
        self.overview = try values.decode(String.self, forKey: .overview)
        self.genreIds = try values.decode([Int].self, forKey: .genreIds)
        self.posterPath = try values.decode(String.self, forKey: .posterPath)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.overview, forKey: .overview)
        try container.encode(self.releaseDate.toISOFormat, forKey: .relaseDate)
        try container.encode(self.genreIds, forKey: .genreIds)
        try container.encode(self.posterPath, forKey: .posterPath)
    }
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.releaseDate == rhs.releaseDate && lhs.overview == rhs.overview && lhs.genreIds == rhs.genreIds && lhs.posterPath == rhs.posterPath
    }
}

// MARK: - Init for Unit Testing -
extension Movie {
    init(id: Int, title: String, releaseDate: Date, overview: String, genreIds: [Int], posterPath: String) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.genreIds = genreIds
        self.posterPath = posterPath
    }
}
