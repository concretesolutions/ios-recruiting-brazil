//
//  Movie.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//
// swiftlint:disable identifier_name

import UIKit

class Movie {
    let id: Int
    let title: String
    let releaseDate: String
    let synopsis: String
    let posterPath: String?
    var posterImage: UIImage?
    let genres: Set<String>
    let isFavorite: Bool

    init(movie: MovieDTO) {
        self.id = movie.id
        self.title = movie.title
        self.releaseDate = String(movie.releaseDate.prefix(4))
        self.synopsis = movie.synopsis
        self.posterPath = movie.posterPath
        self.posterImage = nil
        self.genres = []
        self.isFavorite = false
    }
}
