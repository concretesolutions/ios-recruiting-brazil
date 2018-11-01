//
//  FavoriteMoviesPersistence.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

protocol FavoritesPersistence: class {
    
    var favorites: Set<Movie> { get }
    
    func isFavorite(_ movie: Movie) -> Bool
    
    @discardableResult
    func toggleFavorite(movie: Movie) -> Bool
    
    func fetchFavorites() -> [Movie]?
}
