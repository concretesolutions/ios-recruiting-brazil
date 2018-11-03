//
//  MoviePersistenceMock.swift
//  MovTests
//
//  Created by Miguel Nery on 26/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
@testable import Mov


class FavoritesPersistenceMock: FavoritesPersistence {
    
    let mockMovies = (0..<3).map { Movie.mock(id: $0) }
    
    var calls = Set<Method>()
    
    var raiseOnToggle = false
    var raiseOnFetch = false
    
    func toggleFavorite(movie: Movie) throws {
        self.calls.insert(.toggleFavorite)
        if (raiseOnToggle) { throw MockError.fail }
    }
    
    func fetchFavorites() throws -> Set<Movie> {
        self.calls.insert(.fetchFavorites)
        if (raiseOnFetch) { throw MockError.fail }
        else { return Set<Movie>(self.mockMovies) }
    }
}


extension FavoritesPersistenceMock: Spy {
    
    typealias MockMethod = FavoritesPersistenceMock.Method
    
    enum Method {
        case fetchFavorites
        case toggleFavorite
    }
}
