//
//  RealmMovieModel.swift
//  Movs
//
//  Created by Dielson Sales on 04/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RealmSwift

class RealmMovieModel: Object {
    @objc dynamic var movieId = -1
    @objc dynamic var title = ""
    @objc dynamic var releaseDate = ""
    @objc dynamic var overview = ""
    @objc dynamic var posterPath = ""

    override static func primaryKey() -> String? {
        return "movieId"
    }

    convenience init(movie: Movie) {
        self.init()
        self.movieId = movie.movieId
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.overview = movie.overview
        self.posterPath = movie.posterPath
    }

    func toMovie() -> Movie {
        let movie = Movie()
        movie.movieId = self.movieId
        movie.title = self.title
        movie.releaseDate = self.releaseDate
        movie.overview = self.overview
        movie.posterPath = self.posterPath
        movie.isFavorited = true
        return movie
    }
}
