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
    public var flawedFetch = false
    public var mockMovies = (0..<5).map { id in
        return Movie(id: id, title: "", releaseDate: Date(), genres: [], overview: "", posterPath: "")
    }
    
    func fetchMovies() -> [Movie]? {
        return flawedFetch ? nil : self.mockMovies
    }
    
    
}
