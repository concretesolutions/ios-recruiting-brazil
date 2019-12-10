//
//  MovieViewModel.swift
//  Movs
//
//  Created by Lucca Ferreira on 04/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation

struct MovieViewModel {

    var id: Int
    var title: String
    var overview: String
    var releaseDate: String
    var poster: String?

    init(withMovie movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.poster = movie.posterPath
    }

}
