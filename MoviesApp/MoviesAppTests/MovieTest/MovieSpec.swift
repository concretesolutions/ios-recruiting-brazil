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
    
    override func spec() {
        let movieMock = MovieMock()
        
        describe("Check data validation in the movie") {
            it("has to be equal to the formated value"){
                expect(movieMock.mock.date) == "2019"
            }
        }
        
        describe("Check gender validation in the movie") {
            it("should have a name"){
                expect(movieMock.mock.genres[0].name) == "Action"
            }
        }
        
        describe("Check image validation in the movie") {
            it("should not be a nil result"){
                expect(movieMock.mock.bannerImage).notTo(beNil())
            }
        }
    }
}
