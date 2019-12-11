// swiftlint:disable identifier_name

//
//  Movie.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class Movie {
    
    // MARK: - Attributes
    
    let id: Int
    let backdropPath: String?
    let genres: Set<Genre>
    let posterPath: String?
    let releaseDate: Date
    let title: String
    let summary: String
    
    // MARK: - Initializers and Deinitializers
    
    init(id: Int, backdropPath: String?, genres: Set<Genre>, posterPath: String?, releaseDate: String, title: String, summary: String) {
        self.id = id
        self.backdropPath = backdropPath
        self.genres = genres
        self.posterPath = posterPath
        self.releaseDate = Date(string: releaseDate)
        self.title = title
        self.summary = summary
    }
    
    convenience init(favoriteMovie: CDFavoriteMovie, genres: [GenreDTO]) {        
        let date = String(date: favoriteMovie.releaseDate!, components: [.year, .month, .day])
        let genres: Set<Genre> = Set(
            genres.filter({ genreDTO in
                favoriteMovie.genreIDs!.contains(genreDTO.id)
            }).map({ genreDTO in
                Genre(genreDTO: genreDTO)
            })
        )

        self.init(id: Int(favoriteMovie.id), backdropPath: favoriteMovie.backdropPath, genres: genres, posterPath: favoriteMovie.posterPath, releaseDate: date, title: favoriteMovie.title!, summary: favoriteMovie.summary!)
    }
    
    convenience init(movieDTO: MovieDTO, genres: [GenreDTO]) {
        let genres: Set<Genre> = Set(
            genres.filter({ genreDTO in
                movieDTO.genreIDS.contains(genreDTO.id)
            }).map({ genreDTO in
                Genre(genreDTO: genreDTO)
            })
        )

        self.init(id: movieDTO.id, backdropPath: movieDTO.backdropPath, genres: genres, posterPath: movieDTO.posterPath, releaseDate: movieDTO.releaseDate, title: movieDTO.title, summary: movieDTO.overview)
    }
}
