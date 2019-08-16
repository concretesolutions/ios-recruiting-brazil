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
    
    var movie = Movie(from: <#Decoder#>)
    var simpleMovie = SimplifiedMovie(movie: movie)
    
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
