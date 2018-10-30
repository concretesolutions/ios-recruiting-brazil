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
    
    enum Method: Equatable {
        case presentMovies
        case presentNetworkError
    }
    
    private var calls = Set<Method>()
    
    public var receivedMovies = [MovieGridUnit]()
    
    public func didCall(method: Method) -> Bool {
        return self.calls.contains(method)
    }
    
    func present(movies: [MovieGridUnit]) {
        self.calls.insert(.presentMovies)
        self.receivedMovies = movies
    }
    
    func presentNetworkError() {
        self.calls.insert(.presentNetworkError)
    }
    
}
