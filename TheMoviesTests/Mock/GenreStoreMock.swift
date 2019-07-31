//
//  GenreStoreMock.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Foundation
@testable import TheMovies

class GenreStoreMock {
    
    private var favorites = false
    var mock: [Genre]
    
    init(withFavorites: Bool = false) {
        self.favorites = withFavorites
        
        self.mock = [
            Genre(id: 0, name: "Action"),
            Genre(id: 1, name: "Adventure"),
            Genre(id: 2, name: "Horror"),
            Genre(id: 3, name: "Drama"),
            Genre(id: 4, name: "Animation"),
            Genre(id: 5, name: "Romantic"),
        ]
    }
    
}
