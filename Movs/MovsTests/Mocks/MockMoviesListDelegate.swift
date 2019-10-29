//
//  MockMoviesListDelegate.swift
//  MovsTests
//
//  Created by Bruno Barbosa on 29/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation
@testable import Movs

class MockMoviesListDelegate: MoviesListDelegate {
    var didUpdateMoviesListClosure: (()->())?
    
    func toggleLoading(_ isLoading: Bool) {
        // TODO
    }
    
    func moviesListUpdated() {
        self.didUpdateMoviesListClosure?()
    }
    
    func errorFetchingMovies(error: APIError) {
        // TODO
    }
    
    
}
