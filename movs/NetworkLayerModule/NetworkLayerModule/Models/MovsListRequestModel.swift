//
//  Person.swift
//  NetworkLayerModule
//
//  Created by Marcos Felipe Souza on 08/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//


import Foundation

// MARK: - MovsListRequest
public struct MovsListRequestModel: Codable {
    public let createdBy, movsListRequestDescription: String
    public let favoriteCount: Int
    public let id: String
    public let items: [Item]
    public let itemCount: Int
    public let iso639_1, name: String
    public let posterPath: JSONNull?

    public enum CodingKeys: String, CodingKey {
        case createdBy = "created_by"
        case movsListRequestDescription = "description"
        case favoriteCount = "favorite_count"
        case id, items
        case itemCount = "item_count"
        case iso639_1 = "iso_639_1"
        case name
        case posterPath = "poster_path"
    }
}

// MARK: - Item
public struct Item: Codable {
    public let originalName: String?
    public let id: Int
    public let mediaType: String
    public let name: String?
    public let popularity: Double
    public let voteCount: Int
    public let voteAverage: Double
    public let firstAirDate: String?
    public let posterPath: String
    public let genreIDS: [Int]
    public let originalLanguage, backdropPath, overview: String
    public let originCountry: [String]?
    public let video: Bool?
    public let title, releaseDate, originalTitle: String?
    public let adult: Bool?

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case id
        case mediaType = "media_type"
        case name, popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case overview
        case originCountry = "origin_country"
        case video, title
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case adult
    }
}

// MARK: - Encode/decode helpers

public class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
