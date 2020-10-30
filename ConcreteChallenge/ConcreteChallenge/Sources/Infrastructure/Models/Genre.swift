//
//  Genre.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 30/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

struct Genre: Codable {
    let id: Int
    let name: String

    // MARK: - Codable conforms

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
