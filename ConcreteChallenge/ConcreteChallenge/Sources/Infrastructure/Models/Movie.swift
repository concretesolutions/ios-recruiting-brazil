//
//  Movie.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class Movie {
    let id: Int
    let title: String
    let imageURL: String
    let genres: String?
    let releaseDate: String
    let overview: String
    var isFavorite: Bool = false

    // MARK: - Initializers

    init(id: Int, title: String, imageURL: String, genres: String?, releaseDate: String, overview: String, isFavorite: Bool) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.genres = genres
        self.releaseDate = releaseDate
        self.overview = overview
        self.isFavorite = isFavorite
    }
}
