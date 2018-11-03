//
//  APIParserTests.swift
//  MovsTests
//
//  Created by Gabriel Reynoso on 02/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import XCTest
@testable import Movs

class APIParserTests: XCTestCase {
    
    let movieParser = APIParser<Movie>()
    let movieDetailParser = APIParser<MovieDetail>()
    
    func testAPIParserShouldParseMovie() {
        let jsonData = "{\"id\": 335983, \"title\": \"Venom\", \"poster_path\": \"/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg\"}".data(using: .utf8)!
        let result = self.movieParser.parse(data: jsonData)
        XCTAssertNotNil(result)
        XCTAssertTrue(result?.id == 335983)
        XCTAssertTrue(result?.title == "Venom")
        XCTAssertTrue(result?.posterPath == "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg")
    }
    
    func testAPIParserShouldReturnNilBecauseOfMissingValues() {
        let jsonData = "{}".data(using: .utf8)!
        let movie = self.movieParser.parse(data: jsonData)
        let movieDetail = self.movieDetailParser.parse(data: jsonData)
        XCTAssertNil(movie)
        XCTAssertNil(movieDetail)
    }
    
    func testAPIParserShouldReturnNilBecauseOfDataCorrupted() {
        let htmlData = "<html></html>".data(using:.utf8)!
        let movie = self.movieParser.parse(data: htmlData)
        let movieDetail = self.movieDetailParser.parse(data: htmlData)
        XCTAssertNil(movie)
        XCTAssertNil(movieDetail)
    }
    
    func testAPIParserShouldParseMovieDetail() {
        let jsonData = "{\"id\": 335983, \"title\": \"Venom\", \"poster_path\": \"/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg\", \"genres\":[], \"overview\":\"Over\", \"release_date\":\"1997-03-12\"}".data(using: .utf8)!
        let result = self.movieDetailParser.parse(data: jsonData)
        XCTAssertNotNil(result)
        XCTAssertTrue(result?.id == 335983)
        XCTAssertTrue(result?.title == "Venom")
        XCTAssertTrue(result?.posterPath == "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg")
        XCTAssertTrue(result?.genres.count == 0)
        XCTAssertTrue(result?.releaseDate == "1997-03-12")
        XCTAssertTrue(result?.releaseYear == "1997")
        XCTAssertTrue(result?.overview == "Over")
    }
}
