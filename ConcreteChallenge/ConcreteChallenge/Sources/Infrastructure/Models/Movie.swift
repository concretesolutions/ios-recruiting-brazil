//
//  Movie.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import RealmSwift

@objcMembers final class Movie: Object, RealmModelProtocol {
    dynamic var id: Int = 0
    dynamic var title: String = ""
    dynamic var imageURL: String = ""
    dynamic var genres: String? = nil
    dynamic var releaseDate: String = ""
    dynamic var overview: String = ""
    var isFavorite: Bool = false

    // MARK: - Initializers

    convenience init(id: Int, title: String, imageURL: String, genres: String?, releaseDate: String, overview: String, isFavorite: Bool = false) {
        self.init()

        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.genres = genres
        self.releaseDate = releaseDate
        self.overview = overview
        self.isFavorite = isFavorite
    }

    // MARK: - Override functions

    override static func primaryKey() -> String? {
        return Constants.MovieDatabase.moviePrimaryKey
    }

    // MARK: - Functions

    func clone() -> Movie {
        return Movie(id: id, title: title, imageURL: imageURL, genres: genres, releaseDate: releaseDate, overview: overview, isFavorite: isFavorite)
    }
}
