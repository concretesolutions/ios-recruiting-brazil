//
//  MovieTests.swift
//  MoviesTests
//
//  Created by Jonathan Martins on 20/09/2018.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import XCTest
@testable import Movies

class MovieTests: XCTestCase {
    
    private let FAVORITE_TEST = "test_favorited_movies"

    override func setUp() {
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// This test asserts that if a nil String is passed, the result will be an empty [Movie] object
    func testConvertNilObjectToEmptyMovieList() {
        let list = Movie.convertJsonStringToFavoriteList(nil)
        XCTAssertTrue(list.isEmpty, "The list should be empty, The returned value should be true")
    }
    
    /// This test asserts that if any Json String that is not an [Movie] is passed, the result will be an empty [Movie] object
    func testConvertAnyWrongStringToEmptyMovieList() {
        var list = Movie.convertJsonStringToFavoriteList("")
        XCTAssertTrue(list.isEmpty, "The list should be empty, The returned value should be true")
        
        list = Movie.convertJsonStringToFavoriteList("fasdd")
        XCTAssertTrue(list.isEmpty, "The list should be empty, The returned value should be true")
        
        list = Movie.convertJsonStringToFavoriteList("fasdd")
        XCTAssertTrue(list.isEmpty, "The list should be empty, thus, The returned value should be true")
    }
    
    /// This test asserts that if an Json String of [Movie] is passed, the result will be an [Movie] object
    func testConvertMovieArrayJsonToMovieArrayObject() {
        let json = movieArrayToJson()
        let list = Movie.convertJsonStringToFavoriteList(json)
        XCTAssertTrue(!list.isEmpty, "The list should not be empty, thus, The returned value should be true")
    }
    
    /// This test asserts that if an [Movie] object is passed, the result will be a String not empty
    func testConvertMovieArrayObjectToArrayJson() {
        let json = movieArrayToJson()
        XCTAssertTrue(!json!.isEmpty, "The json should not be empty, thus, The returned value should be true")
    }
    
    /// Converts an [Movie] to Json String
    private func movieArrayToJson()->String?{
        let movies = [Movie(withId: 10), Movie(withId: 20)]
        return Movie.convertFavoriteListToJsonString(movies)
    }
}
