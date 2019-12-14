//
//  StringTests.swift
//  MovsTests
//
//  Created by Gabriel D'Luca on 14/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Movs

class StringTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: String!
    var conversionDate: Date!
    
    // MARK: - Setup and Teardown
    
    override func setUp() {
        self.conversionDate = Date(timeIntervalSince1970: -1 * 21 * 60 * 60) // - 21:00
    }
    
    override func tearDown() {
        self.sut = nil
        self.conversionDate = nil
    }
    
    // MARK: - Tests
    
    func testShouldCreateStringFromDate() {
        self.sut = String(date: self.conversionDate)
        expect(self.sut).to(equal("1969-12-31"))
    }
}
