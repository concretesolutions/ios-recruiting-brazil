//
//  MoviesTests.swift
//  ConcreteChallengeTests
//
//  Created by Erick Pinheiro on 29/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import ReSwift

import XCTest

@testable import ConcreteChallenge

struct EmptyAction: Action { }

func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map { _ in letters.randomElement()! })
}

func movieFactory() -> Movie {
    return Movie(
        id: Int.random(in: 1..<100),
        posterPath: randomString(length: 50),
        adult: false,
        overview: randomString(length: 200),
        releaseDate: "2020-02-02",
        genreIds: [2, 3],
        genres: [randomString(length: 8), randomString(length: 8)],
        originalTitle: randomString(length: 8),
        originalLanguage: "pt-BR",
        title: randomString(length: 8),
        backdropPath: nil,
        video: false,
        popularity: Double.random(in: 1..<900),
        voteCount: Int.random(in: 600..<900),
        voteAverage: Double.random(in: 0..<10),
        favorited: false
    )
}

class MoviesModelTests: XCTestCase {

    var movie: Movie! = movieFactory()

    override class func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        movie = nil
    }

    func testCloneInstance() {
        do {
            let clone = try movie.clone()
            XCTAssertEqual(clone.genreIds, movie.genreIds)
        } catch {
            XCTFail()
        }
    }

    func testInitialState() {
        let state = rootReducer(action: EmptyAction(), state: nil)
        XCTAssertEqual(state, RootState())
    }

    func testAddMovies() {
        let movies1 = [movieFactory(), movieFactory()]
        let movies2 = [movieFactory(), movieFactory()]

        let action = MovieActions.addMovies(
            movies1,
            page: 1,
            total: 10,
            filters: MovieFilters()
        )

        let action2 = MovieActions.addMovies(
            movies2,
            page: 2,
            total: 15,
            filters: MovieFilters()
        )

        let state = rootReducer(action: action, state: nil)
        let state2 = rootReducer(action: action2, state: state)

        XCTAssert(state2.movie.totalPages == 15)
        XCTAssert(state2.movie.page == 2)
        XCTAssert(state2.movie.movies.count == 4)
        XCTAssert(state2.movie.movies[0].title == movies1[0].title)
        XCTAssert(state2.movie.movies[1].title == movies1[1].title)
        XCTAssert(state2.movie.movies[2].title == movies2[0].title)
        XCTAssert(state2.movie.movies[3].title == movies2[1].title)

    }

    func testSetMovieDetailsModelUsingMovieModel() {
        let movieDetails = MovieDetails(with: movie)
        XCTAssertEqual(movieDetails.id, movie.id)

        let action = MovieActions.movieDetails(movieDetails)
        let state = rootReducer(action: action, state: nil)

        XCTAssertNotNil(state.movie.currentMovieDetails)
        XCTAssert(state.movie.currentMovieDetails?.id == movie.id)
        XCTAssert(state.movie.currentMovieDetails?.title == movie.title)
        XCTAssert(state.movie.currentMovieDetails?.favorited == movie.favorited)
        XCTAssert(state.movie.currentMovieDetails?.overview == movie.overview)
    }

    func testUpdateMovieDetails() {
        let movieDetails = MovieDetails(with: movie)
        let movieDetails2 = MovieDetails(with: movie)
        movieDetails2.favorited = !movieDetails.favorited!

        let action = MovieActions.movieDetails(movieDetails)
        let state = rootReducer(action: action, state: nil)

        let action2 = MovieActions.updateMovieDetails(movieDetails2)
        let state2 = rootReducer(action: action2, state: state)

        let movieDetailsFromState = state.movie.currentMovieDetails
        let movieDetailsUpdatedFromState = state2.movie.currentMovieDetails

        XCTAssertNotNil(movieDetailsFromState)
        XCTAssertNotNil(movieDetailsUpdatedFromState)
        XCTAssert(movieDetailsFromState?.id == movieDetailsUpdatedFromState?.id)
        XCTAssert(movieDetailsFromState?.title == movieDetailsUpdatedFromState?.title)
        XCTAssertFalse(movieDetailsFromState?.favorited == movieDetailsUpdatedFromState?.favorited)
        XCTAssert(movieDetailsFromState?.overview == movieDetailsUpdatedFromState?.overview)

    }

    func testRequestStatesChange() {

        let action = MovieActions.requestStated(isSearching: true, isPaginating: false)
        let state = rootReducer(action: action, state: nil)
        XCTAssertTrue(state.movie.loading)
        XCTAssertTrue(state.movie.isSearching)
        XCTAssertFalse(state.movie.isPaginating)

        let action2 = MovieActions.requestStated(isSearching: false, isPaginating: true)
        let state2 = rootReducer(action: action2, state: nil)
        XCTAssertTrue(state2.movie.loading)
        XCTAssertFalse(state2.movie.isSearching)
        XCTAssertTrue(state2.movie.isPaginating)

        let action3 = MovieActions.requestStated(isSearching: true, isPaginating: true)
        let state3 = rootReducer(action: action3, state: nil)
        XCTAssertTrue(state3.movie.loading)
        XCTAssertTrue(state3.movie.isSearching)
        XCTAssertTrue(state3.movie.isPaginating)

        let errorMessage = "Error requesting movies to the server"
        let state4 = rootReducer(action: MovieActions.requestError(message: errorMessage), state: state3)
        XCTAssertFalse(state4.movie.loading)
        XCTAssertFalse(state4.movie.isSearching)
        XCTAssertFalse(state4.movie.isPaginating)
        XCTAssertEqual(state4.movie.errorMessage, errorMessage)

    }

}
