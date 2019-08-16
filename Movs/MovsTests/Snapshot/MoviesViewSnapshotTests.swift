//
//  MoviesViewSnapshotTests.swift
//  MovsTests
//
//  Created by Douglas Silveira Machado on 15/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs
import OHHTTPStubs
import XCTest

class MoviesViewSnapshotTests: FBSnapshotTestCase {

    var moviesView: MoviesViewController!

    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()
        DependencyInjector.registerDependencies()
        usesDrawViewHierarchyInRect = true
        moviesView = MoviesViewController()
        moviesView.loadViewIfNeeded()
        recordMode = false
    }

    override func tearDown() {
        super.tearDown()
        moviesView.unregisterObservers()
        OHHTTPStubs.removeAllStubs()
    }
    // MARK: - Tests

    func testMoviesGrid() {
        let expect = expectation(description: "wait view to load")

        let moviePage = 1
        let apiKey = MovieApiConfig.privateKey
        let endPoint = "\(MovieApiConfig.EndPoint.popular)?page=\(moviePage)&api_key=\(apiKey)&language=en"
        createStub(withFileName: "Movies200", statusCode: 200, path: endPoint)

        _ = XCTWaiter.wait(for: [expect], timeout: 5)
        takeSnapshotsForAllScreens(view: moviesView.view, needWait: true)
    }
}
