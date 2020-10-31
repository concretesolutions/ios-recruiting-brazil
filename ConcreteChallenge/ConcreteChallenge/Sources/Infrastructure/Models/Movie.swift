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
    let genres: String?
    let releaseDate: String
    let overview: String
    var isFavorite: Bool = false
}
