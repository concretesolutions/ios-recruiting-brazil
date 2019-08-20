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
                expect(movieMock.getYear(completeDate: "2019-09-01")) == "2019"
            }
        }
        
        describe("Check image validation in the movie") {
            it("should not be a nil result"){
                expect(movieMock.getGenres(genresIDS: [28,12])).toNot(beNil())
            }
        }
    }
}
