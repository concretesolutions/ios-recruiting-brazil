//
//  Movie.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//
// swiftlint:disable identifier_name

import Foundation

class Movie {
    let id: Int
    let title: String
    let releaseDate: String
    let synopsis: String
    let posterPath: String?
    let genres: Set<String>
    let isFavorite: Bool

    init(movie: MovieDTO) {
        id = movie.id
        title = movie.title
        releaseDate = String(movie.releaseDate.prefix(4))
        synopsis = movie.synopsis
        posterPath = movie.posterPath
        genres = []
        isFavorite = false
    }
}
