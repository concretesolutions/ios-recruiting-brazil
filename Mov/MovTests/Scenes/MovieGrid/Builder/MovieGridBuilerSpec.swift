//
//  MovieGridBuilerSpec.swift
//  MovTests
//
//  Created by Miguel Nery on 02/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble

@testable import Mov

class MovieGridBuilerSpec: QuickSpec {
    override func spec() {
        describe("MovieGrid builder") {
            
            context("when building") {
                var vc: MovieGridViewController?
                
                beforeEach {
                    vc = MovieGridBuilder.build()
                }
                
                it("should build non nil view controller") {
                    expect(vc).notTo(beNil())
                }
                
                it("should have view controller assigned a interactor") {
                    expect(vc?.interactor).notTo(beNil())
                }
            }
        }
    }
}
