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
    dynamic var idFromApi: Int = 0
    dynamic var title: String = ""
    dynamic var imageURL: String = ""
    dynamic var genres: String? = nil
    dynamic var releaseDate: String = ""
    dynamic var overview: String = ""
    dynamic var isFavorite: Bool = false

    // MARK: - Initializers

    convenience init(idFromApi: Int, title: String, imageURL: String, genres: String?, releaseDate: String, overview: String, isFavorite: Bool = false) {
        self.init()

        self.idFromApi = idFromApi
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
}
