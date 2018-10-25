//
//  MovieFetcherMock.swift
//  FAKTests
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
@testable import FAK

class MovieFetcherMock: MovieFetcher {
    public var flawedFetch = false
    
    func fetchMovies() -> [Movie]? {
        return flawedFetch ? nil : []
    }
    
    
}
