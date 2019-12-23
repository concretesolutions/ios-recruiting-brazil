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
    var movieDetailDTO: MovieDetailDTO!
    var movie: Movie!
    
    override func setUp() {
        super.setUp()
        self.movie = nil
    }
    
    func testMovieDTOInitilializerIsCorrect() {
        let movieDTO = MovieDTO(id: 10,
                                title: "Movie title",
                                releaseDate: "2010-10-10",
                                synopsis: "Movie synopsis",
                                posterPath: "/poster-url-string",
                                genreIDs: nil)
        self.movie = Movie(movie: movieDTO)
        
        XCTAssertEqual(movie.id, 10)
        XCTAssertEqual(movie.title, "Movie title")
        XCTAssertEqual(movie.releaseDate, "2010")
        XCTAssertEqual(movie.synopsis, "Movie synopsis")
        XCTAssertEqual(movie.posterPath, "/poster-url-string")
        XCTAssertEqual(movie.genres, [])
    }
    
    func testMovieDetailDTOInitilializerIsCorrect() {
        let movieDetailDTO = MovieDetailDTO(id: 10,
                                            title: "Movie title",
                                            releaseDate: "2010-10-10",
                                            synopsis: "Movie synopsis",
                                            posterPath: "/poster-url-string",
                                            genres: [
                                                GenreDTO(id: 28, name: "Action"),
                                                GenreDTO(id: 14, name: "Fantasy")
                                            ])
        self.movie = Movie(movie: movieDetailDTO)
        
        XCTAssertEqual(movie.id, 10)
        XCTAssertEqual(movie.title, "Movie title")
        XCTAssertEqual(movie.releaseDate, "2010")
        XCTAssertEqual(movie.synopsis, "Movie synopsis")
        XCTAssertEqual(movie.posterPath, "/poster-url-string")
        XCTAssertEqual(movie.genres, ["Action", "Fantasy"])
    }
}
