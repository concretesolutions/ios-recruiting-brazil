//
//  MovsTests.swift
//  MovsTests
//
//  Created by Lucas Ferraço on 13/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import XCTest
import Foundation

class MovieModelTests: XCTestCase {
	
	func testCompleteMovieDecoding() {
		let json = """
		{
		    "vote_count": 0,
		    "id": 439079,
		    "vote_average": 5.0,
		    "title": "The Nun",
		    "original_language": "en",
		    "original_title": "The Nun",
		    "overview": "Overview test.",
		    "release_date": "2018-09-07"
		}
		""".data(using: .utf8)!
		
		do {
			let movie = try JSONDecoder().decode(Movie.self, from: json)
			
			XCTAssertEqual(movie.id, 439079)
			XCTAssertEqual(movie.localizedTitle, "The Nun")
			XCTAssertEqual(movie.originalTitle, "The Nun")
			XCTAssertEqual(movie.voteAverage, 5.0)
			XCTAssertEqual(movie.overview, "Overview test.")
			XCTAssertEqual(movie.originalLanguage, "en")
			
			let formatter = DateFormatter()
			formatter.dateFormat = "yyyy-MM-dd"
			formatter.calendar = Calendar(identifier: .iso8601)
			XCTAssertEqual(movie.releaseDate, formatter.date(from: "2018-09-07"))
		} catch _ {
			XCTFail()
		}
	}
	
	func testNilMovieDecoding() {
		let json = """
		{
			"id": null,
		    "vote_average": null,
		    "title": null,
		    "original_language": null,
		    "original_title": null,
		    "overview": null,
		    "release_date": null
		}
		""".data(using: .utf8)!
		
		do {
			let movie = try JSONDecoder().decode(Movie.self, from: json)
			
			XCTAssertNil(movie.id)
			XCTAssertNil(movie.localizedTitle)
			XCTAssertNil(movie.voteAverage)
			XCTAssertNil(movie.overview)
			XCTAssertNil(movie.releaseDate)
			XCTAssertNil(movie.originalTitle)
			XCTAssertNil(movie.originalLanguage)
		} catch _ {
			XCTFail()
		}
	}
	
	func testWrongReleaseDateFormatDecoding() {
		let json = """
		{
		    "release_date": "07/09/2018"
		}
		""".data(using: .utf8)!
		
		do {
			let movie = try JSONDecoder().decode(Movie.self, from: json)
			XCTAssertNil(movie.releaseDate)
		} catch _ {
			XCTFail()
		}
	}
}
