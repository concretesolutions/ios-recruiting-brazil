//
//  ManageFavoriteMoviesActions.swift
//  Movs
//
//  Created by Maisa on 28/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

protocol ManageFavoriteMoviesActions {
    func addFavoriteMovie(movie: MovieDetailed) -> Bool
    func removeFavoriteMovie(movie: MovieDetailed) -> Bool
    func getFavoriteMovies() -> [MovieDetailed]
    
}
