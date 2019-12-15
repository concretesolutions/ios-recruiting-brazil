//
//  MovieDTOTests.swift
//  MovsTests
//
//  Created by Gabriel D'Luca on 13/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Movs

class MovieDTOTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: MovieDTO!
    var bundle: Bundle!
    
    // MARK: - Setup and Teardown
    
    override func setUp() {
        self.sut = MovieDTO(id: 76341, backdropPath: "/tbhdm8UJAb4ViCTsulYFL3lxMCd.jpg", genreIDS: [28, 12, 878, 53], popularity: 18.797187, posterPath: "/kqjL17yufvn9OVLyXYpvtyrFfak.jpg", releaseDate: "2015-05-13", title: "Mad Max: Fury Road", overview: "An apocalyptic story set in the furthest reaches of our planet, in a stark desert landscape where humanity is broken, and most everyone is crazed fighting for the necessities of life. Within this world exist two rebels on the run who just might be able to restore order. There's Max, a man of action and a man of few words, who seeks peace of mind following the loss of his wife and child in the aftermath of the chaos. And Furiosa, a woman of action and a woman who believes her path to survival may be achieved if she can make it across the desert back to her childhood homeland.")
        self.bundle = Bundle(for: type(of: self))
    }
    
    override func tearDown() {
        self.sut = nil
    }
    
    // MARK: - Tests
    
    func testShouldDecodeDataForCorrectFormat() {
        do {
            let movie = try JSONDecoder().decode(MovieDTO.self, resourceName: "MovieTestData", resourceType: "json", bundle: self.bundle)
            expect(self.sut).to(equal(movie), description: "Expected decoded data to be parsed correctly.")
        } catch is DecodingError {
            fail("Failed to decode MovieDTO from data.")
        } catch {
            fatalError("Unexpected error while trying to decode MovieDTO from data.")
        }
    }
    
    func testDecodeShouldFailForIncorrectFormat() {
        do {
            _ = try JSONDecoder().decode(MovieDTO.self, resourceName: "GenreTestData", resourceType: "json", bundle: self.bundle)
            fail("Expected MovieDTO decoding throw a DecodingError for incorrect data.")
        } catch is DecodingError {
            _ = succeed()
        } catch {
            fatalError("Unexpected error while trying to decode MovieDTO from data.")
        }
    }
}
