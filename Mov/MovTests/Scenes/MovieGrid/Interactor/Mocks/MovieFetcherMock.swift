//
//  MovieFetcherMock.swift
//  FAKTests
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
@testable import Mov

class MovieFetcherMock: MovieFetcher {
    
    static var fetchedMovies = [Movie]()
    
    public var flawedFetch = false
    
    public var mockMovies = (0..<5).map { Movie.mock(id: $0) }
    
    var calls = Set<MovieFetcherMock.Methods>()
    
    func fetchPopularMovies(page: Int, _ completion: @escaping (Result<[Movie]>) -> Void) {
        self.calls.insert(.fetchPopularMovies)
        
        let result = self.flawedFetch ? Result<[Movie]>.failure(MockError.fail) : Result<[Movie]>.success(self.mockMovies)
        
        completion(result)
    }
}

extension MovieFetcherMock: Spy {
    typealias MockMethod = Methods
    
    enum Methods {
        case fetchPopularMovies
    }
    
}

