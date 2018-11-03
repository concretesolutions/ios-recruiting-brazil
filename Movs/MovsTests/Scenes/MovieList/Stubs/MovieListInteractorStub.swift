//
//  MovieListInteractorStub.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 31/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation
@testable import Movs

class MovieListInteractorStub: MovieListBussinessLogic {
    var presenter: MovieListPresentationLogic!
    
    func fetchMovies(request: MovieList.Request.Page) {
        
    }
    
    func filterMovies(request: MovieList.Request.Movie) {
        
    }
    
    func favoriteMovie(at index: Int) {
        
    }
    
    func storeMovie(at index: Int) {
        
    }
    
    
}
