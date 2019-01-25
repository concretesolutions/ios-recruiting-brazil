//
//  MovieDetailViewModel.swift
//  Movs
//
//  Created by Filipe Jordão on 23/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    let title: String
    let image: URL?
    let genres: String
    let overview: String

    init(movie: Movie, config: MovsConfig) {
        title = movie.title
        genres = config.genres
            .filter { movie.genreIDS.contains($0.id) }
            .map { $0.name }
            .joined(separator: ", ")

        overview = movie.overview
        image = config.imageUrl(movie.posterPath)
    }
}
