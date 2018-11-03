//
//  APIModelTests.swift
//  MovsTests
//
//  Created by Gabriel Reynoso on 03/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import XCTest
@testable import Movs

class APIModelTests: XCTestCase {

    func testMovieDetailShouldNotBeComplete() {
        let mov = Movie(id: 10, title: "John", posterPath: "/john.jgp")
        let favMov = FavoriteMovie(movie: mov)
        XCTAssertFalse(favMov.movieDetail.isComplete)
    }
    
    func testMovieDetailShouldBeComplete() {
        let mov = MovieDetail(id: 10,
                              title: "John",
                              posterPath: "/jhon.jpg",
                              releaseDate: "1997-03-12",
                              genres: [],
                              overview: "Over",
                              isFavorite: false)
        XCTAssertTrue(mov.isComplete)
    }

    func testMovieDetailShouldGenerateGenresNames() {
        let gnr1 = Genre(id: 0, name: "Gnr1")
        let gnr2 = Genre(id: 1, name: "Gnr2")
        let mov = MovieDetail(id: 10,
                              title: "John",
                              posterPath: "/jhon.jpg",
                              releaseDate: "1997-03-12",
                              genres: [gnr1, gnr2],
                              overview: "Over",
                              isFavorite: false)
        XCTAssertTrue(mov.genreNames == "Gnr1, Gnr2, ")
    }
}
