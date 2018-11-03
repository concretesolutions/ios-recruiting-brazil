//
//  FavoritesViewOutputMock.swift
//  MovTests
//
//  Created by Miguel Nery on 02/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

@testable import Mov

class FavoritesViewOutputMock: FavoritesViewOutput {
    var calls = Set<FavoritesViewOutputMock.Methods>()
    
    var receivedViewModels = [FavoritesViewModel]()
    
    var receivedRequest = ""
    
    func display(movies: [FavoritesViewModel]) {
        self.calls.insert(.displayMovies)
        self.receivedViewModels = movies
    }
    
    func displayNoResults(for request: String) {
        self.calls.insert(.displayNoResultsFound)
        self.receivedRequest = request
    }
    
    func displayFetchError() {
        self.calls.insert(.displayFetchError)
    }
    
    func displayFavoritesError() {
        self.calls.insert(.displayFavoritesError)
    }
    
}

extension FavoritesViewOutputMock: Spy {
    typealias MockMethod = Methods
    
    enum Methods {
        case displayMovies
        case displayNoResultsFound
        case displayFetchError
        case displayFavoritesError
    }
    
}
