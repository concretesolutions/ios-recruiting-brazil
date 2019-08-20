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

class DetailsSnapshot: QuickSpec{
    
    let crud = CRUDMock()
    let movie = MovieMock()
    
    override func spec() {
        describe("Detail Screen Visual check") {
            it("Should look like this"){
                let frame = UIScreen.main.bounds
                let view =  DetailsView(frame: frame)
                expect(view) == snapshot("DetailsView")
            }
        }
    }
}
