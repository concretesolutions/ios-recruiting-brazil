//
//  MovieResponse.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

struct MovieResponse: Codable {
    let id: Int
    let title: String
    let imageURL: String
    let genreIds: [Int]
    let overview: String
    let releaseDate: String

    // MARK: - Codable conforms

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case imageURL = "backdrop_path"
        case genreIds = "genre_ids"
        case overview = "overview"
        case releaseDate = "release_date"
    }
}
