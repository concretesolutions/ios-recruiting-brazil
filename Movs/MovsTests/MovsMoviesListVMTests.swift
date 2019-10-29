//
//  MovsMoviesListVMTests.swift
//  MovsTests
//
//  Created by Bruno Barbosa on 29/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import XCTest
@testable import Movs

class MovsMoviesListVMTests: XCTestCase {

    var sut: MoviesListViewModel!
    var mockMovieService: MockMovieService!
    var mockMoviesListDelegate: MockMoviesListDelegate!
    
    override func setUp() {
        super.setUp()
        
        self.mockMovieService = MockMovieService()
        self.sut = MoviesListViewModel(withService: self.mockMovieService)
        
        self.mockMoviesListDelegate = MockMoviesListDelegate()
        self.sut.delegate = self.mockMoviesListDelegate
        
    }

    override func tearDown() {
        self.mockMovieService = nil
        self.mockMoviesListDelegate = nil
        self.sut = nil
        super.tearDown()
    }

    func testMoviesListVMFetching() {
        let promise = expectation(description: "Movies list fetches successfully")
        
        self.mockMoviesListDelegate.didUpdateMoviesListClosure = {
            let movies = self.mockMovieService.popularMovies
            XCTAssertNotEqual(movies, [], "Didn't update the popular movies list")
            promise.fulfill()
        }
        
        self.sut.fetchMovies()
        
        wait(for: [promise], timeout: 5)
    }

}
