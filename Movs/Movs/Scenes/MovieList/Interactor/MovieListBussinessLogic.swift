//
//  MovieListBussinessLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieListBussinessLogic {
    /**
     Fetch movies in page requested.
     
     - parameters:
         - request: Page requested.
     */
    func fetchMovies(request: MovieList.Request.Page)
    
    /**
     Filter movies by name.
     
     - parameters:
         - request: Name of the movie requested.
     */
    func filterMovies(request: MovieList.Request.Movie)
    
    /**
     Favorite movie. If is already favorite, unfavorite.
     
     - parameters:
         - index: Index of the movie to be favorite.
     */
    func favoriteMovie(at index: Int)
    
    /**
     Store movie to be displayed details.
     
     - parameters:
         - index: Index of the movie.
     */
    func storeMovie(at index: Int)
}
