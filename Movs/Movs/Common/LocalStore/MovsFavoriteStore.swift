//
//  FavoriteStore.swift
//  Movs
//
//  Created by Filipe Jordão on 24/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation

protocol FavoriteStore {
    func store(movie: Movie)
    func store(movies: [Movie])
    func drop(movie: Movie)
    func contains(movie: Movie) -> Bool
    func update(movie: Movie)
    func fetch() -> [Movie]
}

class MovsFavoriteStore: FavoriteStore {
    let key = "Movies"
    let defaults = UserDefaults.standard

    func store(movies: [Movie]) {
        let ids = self.ids(from: movies)
        let filtered = fetch().filter { !ids.contains($0.identifier) }

        defaults.set(filtered + movies, for: key)
    }

    func update(movie: Movie) {
        if contains(movie: movie) {
            store(movie: movie)
        }
    }

    func fetch() -> [Movie] {
        return defaults.customObject(for: key) ?? []
    }

    func store(movie: Movie) {
        let filtered = fetch().filter { $0.identifier != movie.identifier }

        defaults.set(filtered + [movie], for: key)
    }

    func drop(movie: Movie) {
        let dropped = fetch().filter { $0.identifier != movie.identifier }
        store(movies: dropped)
    }

    func contains(movie: Movie) -> Bool {
        return fetch().contains { $0.identifier == movie.identifier}
    }

    private func ids(from movies: [Movie]) -> [Int] {
        return movies.map { $0.identifier }
    }
}
