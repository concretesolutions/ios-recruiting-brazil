//
//  Movie.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class Movie: NSObject {
    
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
    
    convenience init(favoriteMovie: CDFavoriteMovie, genres: Set<CDGenre>) {
        var dateString: String?
        var filteredGenres: Set<Genre> = Set()
        
        if let movieRelease = favoriteMovie.releaseDate {
            dateString = String(date: movieRelease)
        }
        
        if let movieGenres = favoriteMovie.genres as? Set<CDGenre> {
            let movieGenresIDs = movieGenres.map({ $0.id })
            filteredGenres = Set(
                genres.filter({ cdGenre in
                    movieGenresIDs.contains(cdGenre.id)
                }).map({ cdGenre in
                    Genre(cdGenre: cdGenre)
                })
            )
        }

        self.init(id: Int(favoriteMovie.id), backdropPath: favoriteMovie.backdropPath, genres: filteredGenres, posterPath: favoriteMovie.posterPath, releaseDate: dateString, title: favoriteMovie.title!, summary: favoriteMovie.summary!)
    }
    
    convenience init(movieDTO: MovieDTO, genres: [GenreDTO]) {
        var filteredGenres: Set<Genre> = Set()

        if let genresIDs = movieDTO.genreIDS {
            filteredGenres = Set(
                genres.filter({ genreDTO in
                    genresIDs.contains(genreDTO.id)
                }).map({ genreDTO in
                    Genre(genreDTO: genreDTO)
                })
            )
        }
        
        self.init(id: movieDTO.id, backdropPath: movieDTO.backdropPath, genres: filteredGenres, posterPath: movieDTO.posterPath, releaseDate: movieDTO.releaseDate, title: movieDTO.title, summary: movieDTO.overview)
    }
}
