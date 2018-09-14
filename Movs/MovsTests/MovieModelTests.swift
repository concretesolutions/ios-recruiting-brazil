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
		    "video": false,
		    "vote_average": 0,
		    "title": "The Nun",
		    "popularity": 20.592,
		    "poster_path": "/sFC1ElvoKGdHJIWRpNB3xWJ9lJA.jpg",
		    "original_language": "en",
		    "original_title": "The Nun",
		    "genre_ids": [
		        27,
		        9648,
		        53
		    ],
		    "backdrop_path": "/tfKxFPq4lel0bL80H0C6kGYKGEq.jpg",
		    "adult": false,
		    "overview": "When a young nun at a cloistered abbey in Romania takes her own life, a priest with a haunted past and a novitiate on the threshold of her final vows are sent by the Vatican to investigate. Together they uncover the order’s unholy secret. Risking not only their lives but their faith and their very souls, they confront a malevolent force in the form of the same demonic nun that first terrorized audiences in “The Conjuring 2,” as the abbey becomes a horrific battleground between the living and the damned.",
		    "release_date": "2018-09-07"
		}
		""".data(using: .utf8)!
		
		do {
			let movie = try JSONDecoder().decode(Movie.self, from: json)
			
			XCTAssertEqual(movie.id, 439079)
			XCTAssertEqual(movie.title, "The Nun")
			XCTAssertEqual(movie.overview, "When a young nun at a cloistered abbey in Romania takes her own life, a priest with a haunted past and a novitiate on the threshold of her final vows are sent by the Vatican to investigate. Together they uncover the order’s unholy secret. Risking not only their lives but their faith and their very souls, they confront a malevolent force in the form of the same demonic nun that first terrorized audiences in “The Conjuring 2,” as the abbey becomes a horrific battleground between the living and the damned.")
			XCTAssertEqual(movie.genreIds, [27, 9648, 53])
			
			let formatter = DateFormatter()
			formatter.dateFormat = "yyyy-MM-dd"
			formatter.calendar = Calendar(identifier: .iso8601)
			XCTAssertEqual(movie.releaseDate, formatter.date(from: "2018-09-07"))
			
			XCTAssertEqual(movie.originalTitle, "The Nun")
			XCTAssertEqual(movie.originalLanguage, "en")
			XCTAssertEqual(movie.posterPath, "/sFC1ElvoKGdHJIWRpNB3xWJ9lJA.jpg")
			XCTAssertEqual(movie.backdropPath, "/tfKxFPq4lel0bL80H0C6kGYKGEq.jpg")
		} catch _ {
			XCTFail()
		}
	}
	
	func testNilMovieDecoding() {
		let json = """
		{
		    "vote_count": 0,
		    "id": null,
		    "video": false,
		    "vote_average": 0,
		    "title": null,
		    "popularity": 20.592,
		    "poster_path": null,
		    "original_language": null,
		    "original_title": null,
		    "genre_ids": null,
		    "backdrop_path": null,
		    "adult": false,
		    "overview": null,
		    "release_date": null
		}
		""".data(using: .utf8)!
		
		do {
			let movie = try JSONDecoder().decode(Movie.self, from: json)
			
			XCTAssertNil(movie.id)
			XCTAssertNil(movie.title)
			XCTAssertNil(movie.overview)
			XCTAssertNil(movie.genreIds)
			XCTAssertNil(movie.releaseDate)
			XCTAssertNil(movie.originalTitle)
			XCTAssertNil(movie.originalLanguage)
			XCTAssertNil(movie.posterPath)
			XCTAssertNil(movie.backdropPath)
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
