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
    public var mockMovies = (0..<5).map { id in
        return Movie(id: id, genreIds: [], title: "", overview: "", releaseDate: Date(), posterPath: "")
    }
    
    func fetchPopularMovies(page: Int, _ completion: @escaping (Result<[Movie]>) -> Void) {
        let result = self.flawedFetch ? Result<[Movie]>.failure(ErrorMock.testFailed) : Result<[Movie]>.success(self.mockMovies)
        completion(result)
    }
    
    enum ErrorMock: Error {
        case testFailed
    }
}

