//
//  MovieClientTests.swift
//  ios-challenge-moviedbTests
//
//  Created by Giovanni Severo Barros on 02/03/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import XCTest
@testable import Movies

class MovieClientTests: XCTestCase {
    
    var movies: [Movie]?
    var genres: [Genre]?
    var error: Error?
    
    override func setUp() {
        super.setUp()
        movies = nil
        genres = nil
        error = nil
    }
    
    override func tearDown() {
        movies = nil
        genres = nil
        error = nil
        super.tearDown()
    }
    
    func testGetAllPopularMovies() {
        
        let promise = expectation(description: "Get All Popular Movies Done")
        
        MovieClient.getPopularMovies(page: 1) { (movies, error) in
            self.movies = movies?.movies
            self.error = error
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
        
        XCTAssertNil(error, "Get All Popular Movies Failed")
        XCTAssertNotNil(movies, "No movies received")
    }
    
    func testGetAllGenres() {
        let promise = expectation(description: "Get All Genres")
        
        MovieClient.getAllGenres { (genres, error) in
            self.genres = genres
            self.error = error
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
        
        XCTAssertNil(error, "Get All Popular Movies Failed")
        XCTAssertNotNil(genres, "No genres received")
    }
}
