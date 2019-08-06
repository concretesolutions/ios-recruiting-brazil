//
//  FavoriteMoviesUseCaseMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 05/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

@testable import Movs

class FavoriteMoviesUseCaseMock: FavoriteMoviesUseCase {
    
    var hasCalledFetchFavoriteMovies: Bool = false
    
    var output: FavoriteMoviesInteractorOutput!
    
    func fetchFavoriteMovies() {
        hasCalledFetchFavoriteMovies = true
    }
    
    
}
