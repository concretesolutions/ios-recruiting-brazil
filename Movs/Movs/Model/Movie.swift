//
//  Movie.swift
//  Movs
//
//  Created by Lucca Ferreira on 17/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation

class Movie {

    var id: Int
    var overview: String
    var releaseDate: String
    var genreIds: [Int]
    var title: String
    var posterPath: String?
    @Published var isLiked: Bool = false

    init(withMovie movie: MovieDTO) {
        self.id = movie.id
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.genreIds = movie.genreIds
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.isLiked = false
    }

    init(withMovieDetails movie: MovieWrapperDTO) {
        self.id = movie.id
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.genreIds = movie.genres.compactMap { $0.id }
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.isLiked = false
    }

}
