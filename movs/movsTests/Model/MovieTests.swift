//
//  MovieTests.swift
//  movsTests
//
//  Created by Emerson Victor on 03/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import XCTest
@testable import Movs

class MovieTests: XCTestCase {
    
    // Attributes
    var movieDTO: MovieDTO!
    var movie: Movie!
    
    // Setting up
    override func setUp() {
        super.setUp()
        movieDTO = MovieDTO(id: 10,
                            title: "Movie title",
                            releaseDate: "2010-10-10",
                            synopsis: "Movie synopsis",
                            posterPath: "/poster-url-string",
                            genreIDs: [28, 14])
        movie = Movie(movie: movieDTO)
    }

    override func tearDown() {
        super.tearDown()
        movieDTO = nil
        movie = nil
    }

    /// Test if the initializer ir correct
    func testInitilializerIsCorrect() {
        XCTAssertEqual(movie.id, 10)
        XCTAssertEqual(movie.title, "Movie title")
        XCTAssertEqual(movie.releaseDate, "2010")
        XCTAssertEqual(movie.synopsis, "Movie synopsis")
        XCTAssertEqual(movie.posterPath, "/poster-url-string")
        XCTAssertEqual(movie.genres, ["Action", "Fantasy"])
    }
}
