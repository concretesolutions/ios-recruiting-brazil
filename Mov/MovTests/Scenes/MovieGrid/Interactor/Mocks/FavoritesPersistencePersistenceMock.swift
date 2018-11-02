//
//  MoviePersistenceMock.swift
//  MovTests
//
//  Created by Miguel Nery on 26/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
@testable import Mov


class Mock: FavoritesPersistence {
    
    let mockMovies = (0..<5).map { Movie.mock(id: $0) }
    
    var calls = Set<Method>()
    
    func toggleFavorite(movie: Movie) throws {
        
    }
    
    func fetchFavorites() throws -> Set<Movie> {
        return Set<Movie>(self.mockMovies)
    }
}


extension FavoritesPersistenceMock: Spy {
    
    typealias MockMethod = FavoritesPersistenceMock.Method
    
    enum Method {
        case fetchFavorites
        case toggleFavorite
    }
}
