//
//  FavoriteSnapshot.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/19/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import MoviesApp

class FavoriteSnapshots: QuickSpec{
    
    let movie = MovieMock()
    
    override func spec() {
        describe("Favorite Screen Visual check") {
            it("Should look like this"){
                let frame = UIScreen.main.bounds
                let view =  FavoriteView(frame: frame)
                expect(view) == snapshot("FavoriteView")
            }
        }
        
        describe("Favorite Cell Visual check") {
            it("Should look like this"){
                let cell = FavoriteCell()
                cell.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
                let view =  cell
                
                expect(view) == snapshot("FavoriteCell")
            }
        }
    }
}
