//
//  PopularMoviesDTOTests.swift
//  MovsTests
//
//  Created by Gabriel D'Luca on 13/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Movs

class PopularMoviesDTOTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: PopularMoviesDTO!
    var bundle: Bundle!
    
    // MARK: - Setup and Teardown
    
    override func setUp() {
        self.sut = PopularMoviesDTO(page: 327, results: [])
        self.bundle = Bundle(for: type(of: self))
    }
    
    override func tearDown() {
        self.sut = nil
        self.bundle = nil
    }
    
    // MARK: - Tests
    
    func testShouldDecodeDataForCorrectFormat() {
        do {
            let popularMovies = try JSONDecoder().decode(PopularMoviesDTO.self, resourceName: "PopularMoviesDecodeData", resourceType: "json", bundle: self.bundle)
            expect(self.sut).to(equal(popularMovies), description: "Expected decoded data to be parsed correctly.")
        } catch is DecodingError {
            fail("Failed to decode PopularMoviesDTO from data.")
        } catch {
            fatalError("Unexpected error while trying to decode PopularMoviesDTO from data.")
        }
    }
    
    func testDecodeShouldFailForIncorrectFormat() {
        do {
            _ = try JSONDecoder().decode(PopularMoviesDTO.self, resourceName: "GenresDecodeData", resourceType: "json", bundle: self.bundle)
            fail("Expected PopularMoviesDTO decoding throw a DecodingError for incorrect data.")
        } catch is DecodingError {
            _ = succeed()
        } catch {
            fatalError("Unexpected error while trying to decode PopularMoviesDTO from data.")
        }
    }
}
