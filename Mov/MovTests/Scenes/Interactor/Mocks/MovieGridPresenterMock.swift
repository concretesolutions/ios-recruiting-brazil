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
    
    /**
        All methods this class contains. Used to spy on method calls.
     */
    enum Method: Equatable {
        case presentMovies
        case presentNetworkError
    }
    
    /**
        Every call of method made in this object.
     */
    public var calls: [Method] = []
    
    /**
        MovieGridMovies received through presentMovies method.
     */
    public var receivedMovies = [MovieGridUnit]()
    
    
    /**
        Tells if this method was called only once and alone.
     - Parameter method: method to check
     */
    public func calledAlone(method: Method) -> Bool {
        return self.calls.count == 1 && calls.first! == method
    }
    
    /**
        Reset this mock to it's original state
     */
    public func resetMock() {
        self.calls.removeAll()
        self.receivedMovies.removeAll()
    }
    
    func present(movies: [MovieGridUnit]) {
        self.calls.append(.presentMovies)
        self.receivedMovies = movies
    }
    
    func presentNetworkError() {
        self.calls.append(.presentNetworkError)
    }
    
}
