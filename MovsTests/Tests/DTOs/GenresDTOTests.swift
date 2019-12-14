//
//  GenresDTOTests.swift
//  MovsTests
//
//  Created by Gabriel D'Luca on 14/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Movs

class GenresDTOTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: GenresDTO!

    // MARK: - Setup and Teardown
    
    override func setUp() {
        self.sut = GenresDTO(genres: [])
    }
    
    override func tearDown() {
        self.sut = nil
    }
    
    // MARK: - Tests
    
    func testShouldDecodeDataForCorrectFormat() {
        do {
            let genres = try JSONDecoder().decode(GenresDTO.self, resourceName: "GenresTestData", resourceType: "json")
            expect(self.sut).to(equal(genres), description: "Expected decoded data to be parsed correctly.")
        } catch is DecodingError {
            fail("Failed to decode GenresDTO from data.")
        } catch {
            fatalError("Unexpected error while trying to decode GenresDTO from data.")
        }
    }
    
    func testDecodeShouldFailForIncorrectFormat() {
        do {
            _ = try JSONDecoder().decode(GenresDTO.self, resourceName: "PopularMoviesTestData", resourceType: "json")
            fail("Expected GenresDTO decoding throw a DecodingError for incorrect data.")
        } catch is DecodingError {
            _ = succeed()
        } catch {
            fatalError("Unexpected error while trying to decode GenresDTO from data.")
        }
    }
}
