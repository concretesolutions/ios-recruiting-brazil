//
//  MovieDetailViewModel.swift
//  Movs
//
//  Created by Filipe Jordão on 23/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelDelegate: class {
    func updateFavorite(_ isFavorite: Bool)
}

class MovieDetailViewModel {
    let title: String
    let image: URL?
    let genres: String
    let overview: String
    let isFavorite: Bool

    private let favoriteStore: FavoriteStore
    private let movie: Movie

    weak var delegate: MovieDetailViewModelDelegate?

    init(movie: Movie, config: MovsConfig, favoriteStore: FavoriteStore) {
        self.favoriteStore = favoriteStore
        self.movie = movie

        title = movie.title
        genres = config.genres
            .filter { movie.genreIDS.contains($0.identifier) }
            .map { $0.name }
            .joined(separator: ", ")

        overview = movie.overview
        image = movie.posterPath.map(config.imageUrl)
        isFavorite = favoriteStore.contains(movie: movie)
    }

    func toggleFavorite() {
        if favoriteStore.contains(movie: movie) {
            favoriteStore.drop(movie: movie)
            delegate?.updateFavorite(false)
        } else {
            favoriteStore.store(movie: movie)
            delegate?.updateFavorite(true)
        }
    }
}
