//
//  MovieGridPresenterMock.swift
//  FAKTests
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
@testable import FAK

class MovieGridPresenterMock: MovieGridPresenter {
    
    enum Method {
        case presentMovies
        case presentNetworkError
    }
    
    public var calls: [Method] = []
    
    public func calledOnly(method: Method) -> Bool {
        print(calls)
        return self.calls.count == 1 && calls.first! == method
    }
    
    public func clearCalls() {
        self.calls.removeAll()
    }
    
    func present(movies: [Movie]) {
        self.calls.append(.presentMovies)
    }
    
    func presentNetworkError() {
        self.calls.append(.presentNetworkError)
    }
    
    
}
