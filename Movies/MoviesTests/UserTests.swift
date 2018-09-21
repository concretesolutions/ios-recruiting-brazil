//
//  UserTests.swift
//  MoviesTests
//
//  Created by Jonathan Martins on 21/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import XCTest
@testable import Movies

class UserTests: XCTestCase {
    
    var user:User!

    override func setUp() {
        user = User()
        user.favorites = [Movie(withId: 1), Movie(withId: 3), Movie(withId: 4)]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// This test asserts that a movie exists in the favorited list
    func testCheckAMovieWasFavorited() {
        let movie       = Movie(withId: 3)
        let isFavorited = user.isMovieFavorite(movie: movie)
        
        XCTAssertTrue(isFavorited, "The movie with ID 3 should be in the favorite list, thus, the returned value should be true")
    }
    
    /// This test asserts that a movie does not exist in the favorite
    func testCheckAMovieWasNotFavorited() {
        let movie       = Movie(withId: 10)
        let isFavorited = user.isMovieFavorite(movie: movie)
        
        XCTAssertFalse(isFavorited, "The movie with ID 10 should not be in the favorite list, thus, the returned value should be false")
    }
    
    /// This test asserts that a movie was not favorited by the user
    func testAddMovieToFavoriteList() {
        let movie = Movie(withId: 300)
        user.favorite(movie: movie, true)
        
        XCTAssertTrue(user.isMovieFavorite(movie: movie), "The returned value should be true if the movie was added to the favorited list")
    }
    
    func testRemoveMovieFromFavoriteList() {
        let movie = Movie(withId: 300)
        user.favorite(movie: movie, false)
        
        XCTAssertFalse(user.isMovieFavorite(movie: movie), "The returned value should be false if the movie was removed from the favorited list")
    }
}
