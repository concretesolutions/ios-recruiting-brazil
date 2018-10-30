//
//  FavoriteMoviesPersistence.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

protocol FavoriteMoviesPersistence: class {
    
    var favorites: Set<Movie> { get }
    
    func isFavorite(_ movie: Movie) -> Bool
    
    func addFavorite(movie: Movie) -> Bool
    
    func fetchFavorites() -> Set<Movie>?
}
