//
//  MoviesTests.swift
//  ConcreteChallengeTests
//
//  Created by Erick Pinheiro on 29/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import XCTest
import ReSwift

@testable import ConcreteChallenge

struct EmptyAction: Action { }

class MoviesModelTests: XCTestCase {

    let movieFactory = MovieFactory()

    func testCloneInstance() {
        let movie = movieFactory.generateMovie()
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
        let movies1 = [movieFactory.generateMovie(), movieFactory.generateMovie()]
        let movies2 = [movieFactory.generateMovie(), movieFactory.generateMovie()]

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
        let movie = movieFactory.generateMovie()
        
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
        let movie = movieFactory.generateMovie()
        
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
