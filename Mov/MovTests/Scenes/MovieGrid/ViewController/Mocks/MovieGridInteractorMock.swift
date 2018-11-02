//
//  MovieGridInteractorMock.swift
//  MovTests
//
//  Created by Miguel Nery on 28/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

@testable import Mov

class MovieGridInteractorMock: MovieGridInteractor {

    var calls = Set<Methods>()
    
    let mockMovies = (0..<5).map { Movie.mock(id: $0) }
    
    var receivedPage = 0
    
    var receivedToggleIndex = 0
    
    var receivedFilterString = ""
    
    var receivedMovieIndex = 0
    
    func fetchMovieList(page: Int) {
        self.calls.insert(.fetchMovieLit)
        self.receivedPage = page
    }
    
    func toggleFavoriteMovie(at index: Int) {
        self.calls.insert(.toggleFavoriteMovie)
        self.receivedToggleIndex = index
    }
    
    func filterMoviesBy(string: String) {
        self.calls.insert(.filterMoviesBy)
        self.receivedFilterString = string
    }
    
    func movie(at index: Int) -> Movie? {
        self.calls.insert(.movieAt)
        self.receivedMovieIndex = index
        return self.mockMovies[safe: index]
    }
    
}

extension MovieGridInteractorMock: Spy {
    typealias MockMethod = Methods
    
    enum Methods {
        case fetchMovieLit
        case toggleFavoriteMovie
        case filterMoviesBy
        case movieAt
        
    }
}
