//
//  DetailsViewSpec.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/19/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//


import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import MoviesApp

class DetailSpec: QuickSpec{
    
    override func spec() {
        let viewModel = MovieGridMock()
        
        beforeEach{
        }
        
        describe("Check if a movie is favorite") {
            it("has to be equal to the string"){
                expect(viewModel.checkFavorite(movieID: viewModel.movies[0].id)).to(beTrue())
            }
        }
        
        describe("Check if is loading the movies") {
            it("has to call the function"){
                viewModel.loadMovies()
                expect(viewModel.pageCount) != 0
            }
        }
    }
    
}
