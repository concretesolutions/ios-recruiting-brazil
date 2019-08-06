//
//  FavoriteMoviesInteractorOutputMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 06/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

@testable import Movs

class FavoriteMoviesInteractorOutputMock: FavoriteMoviesInteractorOutput {
    var hasCalledFetchedFavoriteMovies = false
    var hasCalledFetchedFavoriteMoviesFailed = false
    
    func fetchedFavoriteMovies(_: [MovieEntity], posters: [PosterEntity]) {
        hasCalledFetchedFavoriteMovies = true
    }
    
    func fetchedFavoriteMoviesFailed() {
        hasCalledFetchedFavoriteMoviesFailed = true
    }
    
    
}
