//
//  MoviePersistenceMock.swift
//  MovTests
//
//  Created by Miguel Nery on 26/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
@testable import Mov


class MoviePersistenceMock: FavoritesPersistence {
    var favorites = Set<Movie>()
    
    func toggleFavorite(movie: Movie) -> Bool {
        return true
    }
    
    func fetchFavorites() -> Set<Movie>? {
        return []
    }
    
    
    func isFavorite(_ movie: Movie) -> Bool {
        return false
    }
}
