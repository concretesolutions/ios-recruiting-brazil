//
//  MovieGridViewOutPutMock.swift
//  MovTests
//
//  Created by Miguel Nery on 26/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

@testable import Mov

class MovieGridViewOutPutMock: MovieGridViewOutput {
    
    var calls = Set<Methods>()
    
    var receivedViewModels = [MovieGridViewModel]()
    
    var receivedResultRequest = ""
    
    func display(movies: [MovieGridViewModel]) {
        self.calls.insert(.displayMovies)
        self.receivedViewModels = movies
    }
    
    func displayNetworkError() {
        self.calls.insert(.displayNetworkError)
    }
    
    func displayNoResults(for request: String) {
        self.calls.insert(.displayNoResults)
        self.receivedResultRequest = request
    }
}

extension MovieGridViewOutPutMock: Spy {
    typealias MockMethod = Methods
    
    enum Methods {
        case displayMovies
        case displayNetworkError
        case displayNoResults
    }
}
