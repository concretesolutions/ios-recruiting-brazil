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
    let releaseDate: Date?
    let title: String
    let summary: String?
    
    // MARK: - Initializers and Deinitializers
    
    init(id: Int, backdropPath: String?, genres: Set<Genre>, posterPath: String?, releaseDate: String?, title: String, summary: String?) {
        self.id = id
        self.backdropPath = backdropPath
        self.genres = genres
        self.posterPath = posterPath
        self.title = title
        self.summary = summary
        
        if let date = releaseDate {
            do {
                self.releaseDate = try Date(string: date)
            } catch {
                fatalError("Failed to initialize date from string \(date).")
            }
        } else {
            self.releaseDate = nil
        }
    }
    
    convenience init(favoriteMovie: CDFavoriteMovie, genres: [GenreDTO]) {
        let dateString: String?
        if let movieRelease = favoriteMovie.releaseDate {
            dateString = String(date: movieRelease)
        } else {
            dateString = nil
        }
        
        let genres: Set<Genre> = Set(
            genres.filter({ genreDTO in
                favoriteMovie.genreIDs!.contains(genreDTO.id)
            }).map({ genreDTO in
                Genre(genreDTO: genreDTO)
            })
        )

        self.init(id: Int(favoriteMovie.id), backdropPath: favoriteMovie.backdropPath, genres: genres, posterPath: favoriteMovie.posterPath, releaseDate: dateString, title: favoriteMovie.title!, summary: favoriteMovie.summary!)
    }
    
    convenience init(movieDTO: MovieDTO, genres: [GenreDTO]) {
        let filteredGenres: Set<Genre>
        if let genresIDs = movieDTO.genreIDS {
            filteredGenres = Set(
                genres.filter({ genreDTO in
                    genresIDs.contains(genreDTO.id)
                }).map({ genreDTO in
                    Genre(genreDTO: genreDTO)
                })
            )
        } else {
            filteredGenres = Set()
        }
        
        self.init(id: movieDTO.id, backdropPath: movieDTO.backdropPath, genres: filteredGenres, posterPath: movieDTO.posterPath, releaseDate: movieDTO.releaseDate, title: movieDTO.title, summary: movieDTO.overview)
    }
}
