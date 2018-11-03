//
//  FavoriteMoviesWorkerMock.swift
//  MovsTests
//
//  Created by Maisa on 02/11/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

@testable import Movs

class FavoriteMoviesWorkerMock: ManageFavoriteMoviesActions {
    
    static let shared = FavoriteMoviesWorkerMock()
    private init(){}
    
    let favoritesCoreData = [
        MovieDetailed(id: 123, genres: [Genre(id: 23, name: "genre")], genresNames: ["genre"], title: "title", overview: "overview", releaseDate: "2018-10-10", posterPath: "aaa", voteAverage: 8.0, isFavorite: true),
        MovieDetailed(id: 666, genres: [Genre(id: 66, name: "heeyy")], genresNames: ["heeyy"], title: "hell", overview: "overview", releaseDate: "2018-10-10", posterPath: "aaa", voteAverage: 8.0, isFavorite: true)
    ]
    
    func addFavoriteMovie(movie: MovieDetailed) -> Bool {
        if findMovieWith(id: movie.id) {
            return false
        }
        var addingMovie = favoritesCoreData
        addingMovie.append(movie)
        return addingMovie.count == 3 // the count incresed
    }
    
    func removeFavoriteMovie(id: Int) -> Bool {
        let removingMovie = favoritesCoreData.filter{ $0.id != id }
        return removingMovie.count == 1
    }
    
    func getFavoriteMovies() -> [MovieDetailed] {
        return favoritesCoreData
    }
    
    func findMovieWith(id: Int) -> Bool {
        return favoritesCoreData.filter{ $0.id == id }.count == 1
    }

    func getFavoriteMoviesEmpty() -> [MovieDetailed] {
        return []
    }
    
}
