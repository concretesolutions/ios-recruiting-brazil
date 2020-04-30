//
//  MoviesTests.swift
//  ConcreteChallengeTests
//
//  Created by Erick Pinheiro on 29/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import XCTest
@testable import RxSwift

@testable import ConcreteChallenge

class MoviesModelTests: XCTestCase {

    var movie: Movie = Movie(id: 0, posterPath: "http://somesite.com/poster.png", adult: false, overview: "", releaseDate: "2020-02-02", genreIds: [2, 3], genres: ["Comédia", "Drama"], originalTitle: "original title", originalLanguage: "pt-BR", title: "Movie Title", backdropPath: nil, video: false, popularity: 10.0, voteCount: 9999, voteAverage: 7.6, favorited: true)

    override class func setUp() {
        super.setUp()

    }

    override func tearDown() {
       super.tearDown()
    }

    func testCloneInstance() {
        do {
            let clone = try movie.clone()
            XCTAssertTrue(clone.genreIds == movie.genreIds)
        } catch {
            XCTFail()
        }
    }

}
