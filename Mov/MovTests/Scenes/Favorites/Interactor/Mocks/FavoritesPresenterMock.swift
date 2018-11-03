//
//  FavoritesPresenterMock.swift
//  MovTests
//
//  Created by Miguel Nery on 02/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

@testable import Mov

class FavoritesPresenterMock: FavoritesPresenter {
    
    var calls = Set<MockMethod>()
    
    var receivedUnits = [FavoritesUnit]()
    
    var receivedSearchRequest = ""
    
    func present(movies: [FavoritesUnit]) {
        self.calls.insert(.presentMovies)
        self.receivedUnits = movies
    }
    
    func presentNoResultsFound(for request: String) {
        self.calls.insert(.presentNoResultsFound)
        self.receivedSearchRequest = request
    }
    
    func presentError() {
        self.calls.insert(.presentError)
    }
}

extension FavoritesPresenterMock: Spy {
    typealias MockMethod = Methods
    
    enum Methods {
        case presentMovies
        case presentNoResultsFound
        case presentError
    }
}
