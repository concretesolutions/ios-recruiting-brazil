//
//  Movie+initWithCDMovie.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

extension Movie {
    init(cdMovie: CDMovie) {
        self.init(
            id: Int(cdMovie.id),
            title: cdMovie.title,
            posterPath: cdMovie.posterPath,
            backdropPath: nil,
            isAdult: false,
            overview: cdMovie.overview,
            releaseDate: cdMovie.releaseDate,
            genreIDs: []
        )
    }
}
