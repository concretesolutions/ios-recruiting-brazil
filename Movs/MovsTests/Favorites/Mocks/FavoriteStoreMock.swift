//
//  FavoriteStoreMock.swift
//  MovsTests
//
//  Created by Filipe Jordão on 25/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation

@testable import Movs

class FavoriteStoreMock: FavoriteStore {
    func store(movie: Movie) {}

    func store(movies: [Movie]) {}

    func drop(movie: Movie) {}

    func contains(movie: Movie) -> Bool {
        return false
    }

    func update(movie: Movie) {}

    func fetch() -> [Movie] {
        return movies
    }

    var movies: [Movie]

    init(movies: [Movie]) {
        self.movies = movies
    }
}
