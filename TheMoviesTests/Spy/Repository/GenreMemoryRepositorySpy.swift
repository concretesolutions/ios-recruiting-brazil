//
//  GenreMemoryRepositorySpy.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/30/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import XCTest
@testable import TheMovies

class GenreMemoryRepositorySpy: GenreMemoryRepositoryProtocol {
    
    var callCacheCount = 0
    var callGetAllCount = 0
    var callGetGenreCount = 0
    
    func cache(genres: [Genre]) {
        callCacheCount+=1
    }
    
    func getAll() -> [Genre] {
        callGetAllCount+=1
        return []
    }
    
    func getGenre(with id: Int) -> Genre? {
        callGetGenreCount+=1
        return Genre(id: id, name: "Test")
    }
}
