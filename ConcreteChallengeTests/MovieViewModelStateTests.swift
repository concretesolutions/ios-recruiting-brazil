//
//  MovieViewModelStateTests.swift
//  ConcreteChallengeTests
//
//  Created by Erick Pinheiro on 30/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import XCTest
import ReSwift

@testable import ConcreteChallenge

class MovieViewModelStateTests: XCTestCase {

    let movieFactory = MovieFactory()
    
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

        let actionState = rootReducer(action: action, state: nil)
        let actionState2 = rootReducer(action: action2, state: actionState)
        
        let state = PopularMoviesViewModel(state: actionState2)

        XCTAssert(state.totalPages == 15)
        XCTAssert(state.page == 2)
        XCTAssert(state.movies.count == 4)
        XCTAssert(state.loadingFooterState == .hidden)
        XCTAssert(state.movies[0].title == movies1[0].title)
        XCTAssert(state.movies[1].title == movies1[1].title)
        XCTAssert(state.movies[2].title == movies2[0].title)
        XCTAssert(state.movies[3].title == movies2[1].title)

    }
    

    func testRequestStatesChange() {
        
        let movies1 = [movieFactory.generateMovie(), movieFactory.generateMovie()]

        let action = MovieActions.addMovies(
            movies1,
            page: 1,
            total: 10,
            filters: MovieFilters()
        )

        let action2 = MovieActions.requestStated(isSearching: true, isPaginating: true)
        
        let actionState = rootReducer(action: action, state: RootState())
        let actionState2 = rootReducer(action: action2, state: actionState)
        
        
        let state = PopularMoviesViewModel(state: actionState2)
        
        XCTAssertTrue(state.loading)
        XCTAssert(state.loadingFooterState == .loading)

    }

}
