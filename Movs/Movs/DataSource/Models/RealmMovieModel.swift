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
    let genres = List<String>()

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
        for genre in movie.genres {
            self.genres.append(genre)
        }
    }

    func toMovie() -> Movie {
        let movie = Movie()
        movie.movieId = self.movieId
        movie.title = self.title
        movie.releaseDate = self.releaseDate
        movie.overview = self.overview
        movie.posterPath = self.posterPath
        movie.isFavorited = true
        for genre in self.genres {
            movie.genres.append(genre)
        }
        return movie
    }
}
