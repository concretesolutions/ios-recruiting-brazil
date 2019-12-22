//
//  Movie.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var id: Int
    var title: String?
    var posterPath: String?
    var backdropPath: String?
    var isAdult: Bool?
    var overview: String?
    var releaseDate: String?
    var genreIDs: [Int]
    
    var posterURL: URL? {
        guard let posterPath = self.posterPath else {
            return nil
        }
        return URL(string: posterPath)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case isAdult = "adult"
        case releaseDate = "release_date"
        case genreIDs = "genre_ids"
    }
}
