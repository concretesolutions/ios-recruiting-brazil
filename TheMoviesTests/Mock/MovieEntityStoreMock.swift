//
//  MovieEntityStoreMock.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/30/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Foundation
@testable import TheMovies

class MovieEntityStoreMock {
    var mock = [
        MovieEntity(id: 0, title: "Filme1", posterPath: "", releaseDate: "", overview: "", genreIds: [0]),
        MovieEntity(id: 1, title: "Filme2", posterPath: "", releaseDate: "", overview: "", genreIds: [0]),
        MovieEntity(id: 2, title: "Filme3", posterPath: "", releaseDate: "", overview: "", genreIds: [0]),
        MovieEntity(id: 3, title: "Filme4", posterPath: "", releaseDate: "", overview: "", genreIds: [0]),
        MovieEntity(id: 4, title: "Filme5", posterPath: "", releaseDate: "", overview: "", genreIds: [0])
    ]
}
