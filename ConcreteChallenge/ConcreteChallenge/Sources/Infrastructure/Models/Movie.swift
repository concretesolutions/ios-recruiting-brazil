//
//  Movie.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

struct Movie: Codable {
    let id: Int
    let title: String
    let imageURL: String
    var isFavorite: Bool = false

    // MARK: - Codable conforms

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case imageURL = "backdrop_path"
    }
}
