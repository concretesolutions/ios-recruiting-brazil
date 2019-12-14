//
//  GenreDTOTests.swift
//  MovsTests
//
//  Created by Gabriel D'Luca on 14/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Movs

class GenreDTOTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: GenreDTO!

    // MARK: - Setup and Teardown
    
    override func setUp() {
        self.sut = GenreDTO(id: 28, name: "Action")
    }
    
    override func tearDown() {
        self.sut = nil
    }
    
    // MARK: - Tests
    
    func testShouldDecodeDataForCorrectFormat() {
        do {
            let genre = try JSONDecoder().decode(GenreDTO.self, resourceName: "GenreTestData", resourceType: "json")
            expect(self.sut).to(equal(genre), description: "Expected decoded data to be parsed correctly.")
        } catch is DecodingError {
            fail("Failed to decode GenreDTO from data.")
        } catch {
            fatalError("Unexpected error while trying to decode GenreDTO from data.")
        }
    }
    
    func testDecodeShouldFailForIncorrectFormat() {
        do {
            _ = try JSONDecoder().decode(GenreDTO.self, resourceName: "MovieTestData", resourceType: "json")
            fail("Expected GenreDTO decoding throw a DecodingError for incorrect data.")
        } catch is DecodingError {
            _ = succeed()
        } catch {
            fatalError("Unexpected error while trying to decode GenreDTO from data.")
        }
    }
}
