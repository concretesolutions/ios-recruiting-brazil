//
//  MovieGridMoack.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/18/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import Foundation

@testable import MoviesApp

class MovieGridMock: MovieGridInterface{
    var pageCount: Int = 0
    var isFavorite = true
    
    var movies: [SimplifiedMovie] = [
    SimplifiedMovie(movieID: 429617, movieTitle: "Nada", movieOverview: "Alo", movieGenres: [28,12], movieDate: "2019859", posterPath: nil),
    SimplifiedMovie(movieID: 429617, movieTitle: "Nada", movieOverview: "Alo", movieGenres: [28,12], movieDate: "2019859", posterPath: nil),
    SimplifiedMovie(movieID: 429617, movieTitle: "Nada", movieOverview: "Alo", movieGenres: [28,12], movieDate: "2019859", posterPath: nil),
    SimplifiedMovie(movieID: 429617, movieTitle: "Nada", movieOverview: "Alo", movieGenres: [28,12], movieDate: "2019859", posterPath: nil)
    ]
    
    func loadMovies() {
        pageCount += pageCount
    }
    
    func checkFavorite(movieID: Int) -> String {
        if movieID == 429617{
            return "Favorite"
        }else{
            return "Not"
        }
    }
    
}
