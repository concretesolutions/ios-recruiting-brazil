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
        let didCall = self.checkIfOnCoordinatorStartedIsCalled(by: AppCoordinator())
        XCTAssertTrue(didCall)
    }
    
    func testMoviesGridCoordinatorShoudCallOnCoordinatorStarted() {
        let didCall = self.checkIfOnCoordinatorStartedIsCalled(by: MoviesGridCoordinator())
        XCTAssertTrue(didCall)
    }
    
    func testMovieDetailCoordinatorShouldCallOnCoordinatorStarted() {
        let didCall = self.checkIfOnCoordinatorStartedIsCalled(by: MovieDetailCoordinator())
        XCTAssertTrue(didCall)
    }
    
    func testFavoriteMoviesCoordinatorShouldCallOnCoordinatorStarted() {
        let didCall = self.checkIfOnCoordinatorStartedIsCalled(by: FavoriteMoviesCoordinator())
        XCTAssertTrue(didCall)
    }
    
    func testFilterCoordinatorShouldCallOnCoordinatorStarted() {
        let didCall = self.checkIfOnCoordinatorStartedIsCalled(by: FilterCoordinator())
        XCTAssertTrue(didCall)
    }
    
    private func checkIfOnCoordinatorStartedIsCalled(by coordinator: Coordinator) -> Bool {
        var didCall: Bool = false
        coordinator.onCoordinatorStarted = { _ in didCall = true }
        coordinator.start()
        return didCall
    }
}
