//
//  NetworkLayerTests.swift
//  ConcreteChallengeTests
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import XCTest
@testable import Movs

class NetworkLayerTests: XCTestCase {
    
    var responseError: Error?
    var responseMovies: [Movie]?
    var responseGenres: [Genre]?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        responseMovies = nil
        responseError = nil
        responseGenres = nil
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        responseMovies = nil
        responseError = nil
        responseGenres = nil
        super.tearDown()
    }

    func testPopularsQuery() {
        
        // given
        let promise = expectation(description: "Populars query")
        
        // when
        MovieClient.getPopular(page: 1) { [weak self] (movies, error) in
            
            self?.responseError = error
            self?.responseMovies = movies
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError, "Error: \(responseError?.localizedDescription ?? "")")
        XCTAssertNotNil(responseMovies, "Error: received no movies")
        XCTAssertFalse(responseMovies?.isEmpty ?? true, "Error: Populars query was empty")
    }
    
    func testGenreListQuery() {
        
        // given
        let promise = expectation(description: "Genre list query")
        
        // when
        MovieClient.getGenreList { [weak self] (genres, error) in
            
            self?.responseGenres = genres
            self?.responseError = error
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError, "Error: \(responseError?.localizedDescription ?? "")")
        XCTAssertNotNil(responseGenres, "Error: received no genres")
        XCTAssertFalse(responseGenres?.isEmpty ?? true, "Error: Genre list empty")
    }
    
    func testSearchQuery() {
        
        // given
        let promise = expectation(description: "Search query")
        
        // when
        MovieClient.search("Frozen") { [weak self] (movies, error) in
            
            self?.responseError = error
            self?.responseMovies = movies
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError, "Error: \(responseError?.localizedDescription ?? "")")
        XCTAssertNotNil(responseMovies, "Error: received no movies")
        XCTAssertFalse(responseMovies?.isEmpty ?? true, "Error: Search query was empty")
    }
    
    func testSearchEmptyQuery() {

        // given
        let promise = expectation(description: "Empty search query")
        
        // when
        MovieClient.search("") { [weak self] (movies, error) in
            
            self?.responseError = error
            self?.responseMovies = movies
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNotNil(responseError, "Error: Empty query had no errors")
        XCTAssertNil(responseMovies, "Error: empty search returned a movie")
    }
    
    func testSearchEmojiQuery() {
        
        // given
        let promise = expectation(description: "Emoji search query")
        
        // when
        MovieClient.search("🖥") { [weak self] (movies, error) in
            
            self?.responseError = error
            self?.responseMovies = movies
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError, "Error: \(responseError?.localizedDescription ?? "")")
        XCTAssertNotNil(responseMovies, "Error: received no results")
        XCTAssertTrue(responseMovies?.isEmpty ?? false, "Error: searching for an emoji returned a movie")
    }
}
