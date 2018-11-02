//
//  FavoriteMoviesPersistence.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

protocol FavoritesPersistence: class {
    
    func toggleFavorite(movie: Movie) throws
    
    func fetchFavorites() throws -> Set<Movie>
}
