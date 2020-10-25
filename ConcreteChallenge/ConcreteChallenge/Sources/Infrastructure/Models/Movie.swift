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
    let image: String

    // MARK: - Codable conforms

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case image = "backdrop_path"
    }
}
