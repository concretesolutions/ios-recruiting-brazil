//
//  FilterTests.swift
//  MoviesTests
//
//  Created by Jonathan Martins on 21/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import XCTest
@testable import Movies

class FilterTests: XCTestCase {
    
    var filter:Filter!

    override func setUp() {
        filter = Filter()
        
        filter.date       = ""
        filter.genre      = Genre()
        filter.hasFilters = true
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// This test asserts that all filters were removed
    func testResetAllFilters(){
        filter.resetAll()
        
        XCTAssertNil(filter.date        , "The field ''date'' should be nil")
        XCTAssertNil(filter.genre       , "The field ''genre'' should be nil")
        XCTAssertFalse(filter.hasFilters, "The field ''hasFilters'' should be false")
    }
}
