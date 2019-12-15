//
//  MoviesGridCellDelegate.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 15/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
extension MoviesGridController: MovieCellDelegate {

    func didFavoriteMovie(movie: MovieDTO, withImage image: UIImage?) {
        if let movies = coreDataManager.fetchMovies() {
            self.fetchedMovies = movies
        }
        if fetchedMovies.contains(where: { $0.name == movie.title}) {
            coreDataManager.deleteMovie(withName: movie.title)
            return
        }
        var genresString = ""
        movie.genreIDs.forEach({genreID in
            genres.forEach({ genre in
                if genreID == genre.genreID {
                    if !genresString.isEmpty {
                        genresString += ", "
                    }
                    genresString += genre.name
                }
            })
        })
        coreDataManager.saveMovie(name: movie.title,
                                  genres: genresString, overview: movie.overview, date: movie.releaseDate, image: image)
    }
}
