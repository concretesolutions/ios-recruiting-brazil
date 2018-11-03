//
//  FavoritesInteractorMock.swift
//  MovTests
//
//  Created by Miguel Nery on 03/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
@testable import Mov

class FavoritesInteractorMock: FavoritesInteractor {
    var calls = Set<Methods>()
    
    var receivedToggleIndex = 0
    var receivedFilterRequest = ""
    var receivedMovieIndex = 0
    
    func fetchFavorites() {
        self.calls.insert(.fetchFavorites)
    }
    
    func toggleFavoriteMovie(at index: Int) {
        self.calls.insert(.toggleFavoriteMovie)
        self.receivedToggleIndex = index
    }
    
    func filterMoviesBy(string: String) {
        self.calls.insert(.filterMoviesBy)
        self.receivedFilterRequest = string
    }
    
    func movie(at index: Int) -> Movie? {
        self.calls.insert(.movieAt)
        self.receivedMovieIndex = index
        
        return Movie.mock(id: index)
    }
}

extension FavoritesInteractorMock: Spy {
    typealias MockMethod = Methods
    
    enum Methods {
        case fetchFavorites
        case toggleFavoriteMovie
        case filterMoviesBy
        case movieAt
        
    }
    
}

