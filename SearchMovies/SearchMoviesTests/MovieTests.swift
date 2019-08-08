//
//  MovieTests.swift
//  SearchMoviesTests
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import XCTest
@testable import SearchMovies

class MovieTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetServiceMovies() {
        let service:MovieListService = MovieListService()
        service.getMovies(appKey: Constants.appKey, pageNumber: 1) { (result) in
            XCTAssert(result.typeReturnService == .success, "OK")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
