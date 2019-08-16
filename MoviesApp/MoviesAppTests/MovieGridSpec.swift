//
//  MovieGridSpec.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/16/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Nimble_Snapshots

@testable import MoviesApp

class MovieGridSpec: QuickSpec{
    
    override func spec() {
        describe("the MovieGrid UI") {
            it("should have the expected look and fell"){
                let frame = UIScreen.main.bounds
                let view =  MovieGridView(frame: frame)
                
                expect(view) == snapshot("MovieGridView")
            }
        }
        
        
    }
}
