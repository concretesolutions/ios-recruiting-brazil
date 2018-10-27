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
    
    private var calls = Set<Methods>()
    
    public var receivedViewModels = [MovieGridViewModel]()
    
    enum Methods {
        case displayMovies
        case displayNetworkError
    }
    
    func didCall(method: Methods) -> Bool {
        return self.calls.contains(method)
    }
    
    func resetMock() {
        self.calls.removeAll()
        self.receivedViewModels.removeAll()
    }
    
    func display(movies: [MovieGridViewModel]) {
        self.calls.insert(.displayMovies)
        self.receivedViewModels.append(contentsOf: movies)
    }
    
    func displayNetworkError() {
        self.calls.insert(.displayNetworkError)
    }
    
    
}
