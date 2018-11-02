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
    
    private var calls = Set<Method>()
    
    public var receivedViewModels = [MovieGridViewModel]()
    
    enum Method {
        case displayMovies
        case displayNetworkError
    }
    
    func didCall(method: Method) -> Bool {
        return self.calls.contains(method)
    }
    
    func display(movies: [MovieGridViewModel]) {
        self.calls.insert(.displayMovies)
        self.receivedViewModels.append(contentsOf: movies)
    }
    
    func displayNetworkError() {
        self.calls.insert(.displayNetworkError)
    }
    
    
}
