//
//  MovieSpec.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/16/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import Quick
import Nimble

@testable import MoviesApp

class MovieSpec: QuickSpec{
    
    var movieMock = MovieMock()
    
    
    override func spec() {
        describe("Check data validation in the movie") {
            it("has to be equal to the formated value"){
                expect(self.movieMock.mock.date) == "2019"
            }
        }
        
        describe("Check gender validation in the movie") {
            it("should be a gender array"){
                expect(self.movieMock.mock.genres[0].name) == "Action"
            }
        }
        
        describe("Check image validation in the movie") {
            it("should not be a nil result"){
                expect(self.movieMock.mock.bannerImage).notTo(beNil())
            }
        }
    }
}
