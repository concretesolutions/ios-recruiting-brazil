//
//  PopularMovieControllerTest.swift
//  theMovie-appTests
//
//  Created by Adriel Alves on 16/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import theMovie_app

class PopularMovieControllerTest: QuickSpec {
    
    override func spec() {
        var sut: PopularMoviesViewController!
        
        describe("Popular Movies View Controller ") {
            
            beforeEach() {
                sut = PopularMoviesViewController()
            }
            
            it("should be able to create a controller") {
                expect(sut).toNot(beNil())
            }
            
        }
    }
}
