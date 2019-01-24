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

    init(movie: Movie) {
        title = movie.title
        genres = movie.genreIDS.map(String.init).joined(separator: ", ")
        overview = movie.overview
        image = URL(string: movie.posterPath)
    }
}
