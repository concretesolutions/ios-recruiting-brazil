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
    var bundle: Bundle!

    // MARK: - Setup and Teardown
    
    override func setUp() {
        self.sut = GenresDTO(genres: [])
        self.bundle = Bundle(for: type(of: self))
    }
    
    override func tearDown() {
        self.sut = nil
        self.bundle = nil
    }
    
    // MARK: - Tests
    
    func testShouldDecodeDataForCorrectFormat() {
        do {
            let genres = try JSONDecoder().decode(GenresDTO.self, resourceName: "GenresDecodeData", resourceType: "json", bundle: self.bundle)
            expect(self.sut).to(equal(genres), description: "Expected decoded data to be parsed correctly.")
        } catch is DecodingError {
            fail("Failed to decode GenresDTO from data.")
        } catch {
            fatalError("Unexpected error while trying to decode GenresDTO from data.")
        }
    }
    
    func testDecodeShouldFailForIncorrectFormat() {
        do {
            _ = try JSONDecoder().decode(GenresDTO.self, resourceName: "PopularMoviesDecodeData", resourceType: "json", bundle: self.bundle)
            fail("Expected GenresDTO decoding throw a DecodingError for incorrect data.")
        } catch is DecodingError {
            _ = succeed()
        } catch {
            fatalError("Unexpected error while trying to decode GenresDTO from data.")
        }
    }
}
