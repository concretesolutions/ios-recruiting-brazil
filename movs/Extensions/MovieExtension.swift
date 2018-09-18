//
//  MovieExtension.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

extension Movie {
    func toMovieData() -> MovieData {
        return MovieData(id: self.id, originalTitle: self.originalTitle, posterPath: self.posterPath, genres: self.genres.map { return $0.toGenreData() }, overview: self.overview, releaseData: self.releaseDate)
    }
}

extension MovieObject {
    func toMovieData() -> MovieData {
        return MovieData(id: self.id, originalTitle: self.originalTitle, posterPath: self.posterPath, genres: self.genres.map { return $0.toGenreData() }, overview: self.overview, releaseData: self.releaseDate)
    }
}
