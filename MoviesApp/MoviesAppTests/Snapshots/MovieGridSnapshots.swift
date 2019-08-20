//
//  MovieGridSnapshots.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/16/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//


import Quick
import Nimble
import Nimble_Snapshots

@testable import MoviesApp

class MovieGridSnapshots: QuickSpec{
 
    override func spec() {
        
        let movie = MovieMock()
        
        describe("Movie Grid Visual check") {
            it("Should look like this"){
                let frame = UIScreen.main.bounds
                let view =  MovieGridView(frame: frame)
                
                expect(view) == snapshot("MovieGridView")
            }
        }
        
        describe("Movie Grid Cell Visual check") {
            it("Should look like this"){
                let cell = MovieGridCell()
                
                cell.configure(withViewModel: movie, isFavorite: true)
                cell.frame = CGRect(x: 0, y: 0, width: 180, height: 280)
                let view =  cell
                
                expect(view) == snapshot("MovieGridCell")
            }
        }
    }
}
