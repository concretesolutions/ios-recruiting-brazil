//
//  DateTests.swift
//  MovsTests
//
//  Created by Gabriel D'Luca on 14/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Movs

class DateTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: Date!
    var conversionString: String!
    
    // MARK: - Setup and Teardown
    
    override func setUp() {
        self.conversionString = "1969-12-31"
    }
    
    override func tearDown() {
        self.sut = nil
        self.conversionString = nil
    }
    
    // MARK: - Tests
    
    func testShouldCreateDateForCorrectFormat() {
        do {
            self.sut = try Date(string: self.conversionString, format: "yyyy-MM-dd")
            let date = Date(timeIntervalSince1970: -1 * 21 * 60 * 60) // - 21:00
            
            expect(self.sut).to(equal(date), description: "Expected appropriate conversion from string.")
        } catch is Date.ConversionError {
            fail("Expected conversion to succeed for correct format.")
        } catch {
            fatalError("Unexpected error while trying to create Date from incorrect format.")
        }
    }
    
    func testConversionShouldFailForIncorrectFormat() {
        do {
            self.sut = try Date(string: self.conversionString, format: "MM-dd-yyyy")
            fail("Expected conversion to throw a ConversionError for incorrect format.")
        } catch is Date.ConversionError {
            _ = succeed()
        } catch {
            fatalError("Unexpected error while trying to create Date from incorrect format.")
        }
    }
}
