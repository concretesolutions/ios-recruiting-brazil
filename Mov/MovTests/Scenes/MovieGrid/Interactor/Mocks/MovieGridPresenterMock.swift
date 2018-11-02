//
//  MovieGridPresenterMock.swift
//  FAKTests
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
@testable import Mov

class MovieGridPresenterMock: MovieGridPresenter {
    
    var calls = Set<Method>()
    
    var receivedUnits = [MovieGridUnit]()
    
    var receivedSearchRequest = ""
    
    
    func present(movies: [MovieGridUnit]) {
        self.calls.insert(.presentMovies)
        self.receivedUnits = movies
    }
    
    func presentNetworkError() {
        self.calls.insert(.presentNetworkError)
    }
    
    func presentNoResultsFound(for request: String) {
        self.calls.insert(.presentNoResultsFound)
        self.receivedSearchRequest = request
    }
}

extension MovieGridPresenterMock: Spy {
    typealias MockMethod = MovieGridPresenterMock.Method
    
    enum Method {
        case presentMovies
        case presentNetworkError
        case presentNoResultsFound
    }
}
