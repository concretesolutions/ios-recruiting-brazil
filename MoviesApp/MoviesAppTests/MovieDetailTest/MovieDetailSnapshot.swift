//
//  MovieDetailSnapshot.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/19/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import MoviesApp

class MovieDetailSnapshots: QuickSpec{
    
    override func spec() {
        
        let movie = MovieMock()
        
        describe("Visual check") {
            it("Should look like this"){
                let frame = UIScreen.main.bounds
                let view =  DetailsView(frame: frame)
                
                expect(view) == snapshot("MovieGridView")
            }
        }
    }
}
