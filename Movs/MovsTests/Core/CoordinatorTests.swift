//
//  CoordinatorTests.swift
//  MovsTests
//
//  Created by Gabriel Reynoso on 25/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import XCTest
@testable import Movs

class CoordinatorTests: XCTestCase {

    func testAppCoordinatorShouldCallOnCoordinatorStarted() {
        let didCall = CoordinatorTests.checkIfOnCoordinatorStartedIsCalled(by: AppCoordinator())
        XCTAssertTrue(didCall)
    }
    
    func testMoviesGridCoordinatorShoudCallOnCoordinatorStarted() {
        let didCall = CoordinatorTests.checkIfOnCoordinatorStartedIsCalled(by: MoviesGridCoordinator())
        XCTAssertTrue(didCall)
    }
    
    func testMovieDetailCoordinatorShouldCallOnCoordinatorStarted() {
        let didCall = CoordinatorTests.checkIfOnCoordinatorStartedIsCalled(by: MovieDetailCoordinator())
        XCTAssertTrue(didCall)
    }
    
    func testFavoriteMoviesCoordinatorShouldCallOnCoordinatorStarted() {
        let didCall = CoordinatorTests.checkIfOnCoordinatorStartedIsCalled(by: FavoriteMoviesCoordinator())
        XCTAssertTrue(didCall)
    }
    
    func testFilterCoordinatorShouldCallOnCoordinatorStarted() {
        let didCall = CoordinatorTests.checkIfOnCoordinatorStartedIsCalled(by: FilterCoordinator())
        XCTAssertTrue(didCall)
    }
    
    static func checkIfOnCoordinatorStartedIsCalled(by coordinator: Coordinator) -> Bool {
        var didCall: Bool = false
        coordinator.onCoordinatorStarted = { _ in didCall = true }
        coordinator.start()
        return didCall
    }
}
