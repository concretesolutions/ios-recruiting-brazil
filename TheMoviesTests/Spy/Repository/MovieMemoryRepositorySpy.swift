//
//  MovieMemoryRepositorySpy.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/30/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import XCTest
@testable import TheMovies

class MovieMemoryRepositorySpy: MovieMemoryRepositoryProtocol {
    
    var callCacheCount = 0
    var callGetAllMoviesCount = 0
    var callGetAllFavoriteMoviesCount = 0
    var callGetMoviesFromPageCount = 0
    var callGetMoviesFromIdCount = 0
    var callIsPageLoadedCount = 0
    var callSetFavoriteMovieCount = 0
    var callRemoveFavoriteMovieCount = 0
    var callGetMoviesYearCount = 0
    
    private var isPageLoaded = false
    private var mock = [Movie]()
    init(isPageLoaded: Bool = false, with mock: [Movie] = []) {
        self.isPageLoaded = isPageLoaded
        self.mock = mock
    }
    
    func cache(page: Int, movies: [Movie]) {
        self.callCacheCount+=1
    }
    
    func getAllMovies() -> [Movie] {
        self.callGetAllMoviesCount+=1
        return []
    }
    
    func getAllFavoriteMovies() -> [Movie] {
        self.callGetAllFavoriteMoviesCount+=1
        return []
    }
    
    func getMovies(from page: Int) -> [Movie] {
        self.callGetMoviesFromPageCount+=1
        return []
    }
    
    func getMovie(from id: Int) -> [Movie] {
        self.callGetMoviesFromIdCount+=1
        return []
    }
    
    func isPageLoaded(page: Int) -> Bool {
        self.callIsPageLoadedCount+=1
        return isPageLoaded
    }
    
    func setFavoriteMovie(id: Int) -> Movie? {
        self.callSetFavoriteMovieCount+=1
        return self.mock.first
    }
    
    func getMoviesYear() -> Set<String> {
        self.callGetMoviesYearCount+=1
        return Set<String>()
    }
}
