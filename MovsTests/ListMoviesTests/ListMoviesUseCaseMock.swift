//
//  ListMoviesInteractorMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 31/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

@testable import Movs

class ListMoviesUseCaseMock: ListMoviesUseCase {
    var hasCalledFetchGenres: Bool = false
    var hasCalledFetchMovies: Bool = false
    var hasCalledFetchPosters: Bool = false
    
    var output: ListMoviesInteractorOutput!
    
    func fetchGenres() {
        hasCalledFetchGenres = true
    }
    
    func fetchMovies() {
        hasCalledFetchMovies = true
    }
    
    func fetchPosters(movies: [MovieEntity]) {
        hasCalledFetchPosters = true
    }
    

}
