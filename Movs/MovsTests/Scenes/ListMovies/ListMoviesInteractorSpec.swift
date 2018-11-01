//
//  ListMoviesInteractorMock.swift
//  MovsTests
//
//  Created by Maisa on 31/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

@testable import Movs

class ListMoviesInteractorMock: ListMoviesInteractor {
    
    var fetchMovies = false
    var networkError = false
    
    enum ViewModel {
        case fetchMovieList
        case networkError
        case serverError
    }
    
    func fetchMovies(from page: Int) {
       fetchMovies = true
    }
    
    func fetchMovie(page: Int) {
       networkError = true
    }
    
}
