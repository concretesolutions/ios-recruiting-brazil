//
//  MovieGridSpec.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/16/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import MoviesApp

class MovieGridSpec: QuickSpec{
    
    var view = MovieGridController()
    
    override func spec() {
        describe("Creating a simplified movie") {
            it(""){
                let frame = UIScreen.main.bounds
                let view =  MovieGridView(frame: frame)
                
                expect(view) == snapshot("MovieGridView")
            }
        }
    }
}
