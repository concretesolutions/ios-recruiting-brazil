//
//  MovieDetailsViewControllerScreenSpec.swift
//  moviesUITests
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import movies

class MovieDetailsViewControllerScreenSpec: QuickSpec {
    override func spec() {
        var sut: MovieDetailsViewControllerScreen!
        
        describe("the 'Details View' ") {
            var movie = MockedDataProvider.shared.popularMovies.first!
            
            context("when is not on favorites list") {
                beforeEach {
                    let viewModel = MovieDetailsViewModel(of: movie)
                    viewModel.favorite = false
                    
                    let frame = UIScreen.main.bounds
                    
                    sut = MovieDetailsViewControllerScreen(frame: frame)
                    sut.setViewModel(viewModel)
                }
                
                it("should have the expected look and feel.") {
                    expect(sut) == snapshot("MovieDetailsView")
                }
            }
            
            context("when is on favorites list") {
                beforeEach {
                    let viewModel = MovieDetailsViewModel(of: movie)
                    viewModel.favorite = true
                    
                    let frame = UIScreen.main.bounds
                    
                    sut = MovieDetailsViewControllerScreen(frame: frame)
                    sut.setViewModel(viewModel)
                }
                
                it("should have the expected look and feel.") {
                    expect(sut) == snapshot("MovieDetailsView_Favorite")
                }
            }
        }
    }
}
