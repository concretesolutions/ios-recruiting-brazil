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

@testable import Movs

class MovieDetailsViewControllerScreenSpec: QuickSpec {
    override func spec() {
        var sut: MovieDetailsViewControllerScreen!
        
        describe("the 'Details View' ") {
            let movie = MockedDataProvider.shared.popularMovies.first!
            let viewModel = MovieDetailsViewModel(of: movie, dataProvider: MockedDataProvider.shared)
            let frame = UIScreen.main.bounds
            
            context("when is not on favorites list") {
                beforeEach {
                    viewModel.favorite = false
                    
                    sut = MovieDetailsViewControllerScreen(frame: frame)
                    sut.setViewModel(viewModel)
                }
                
                it("should have the expected look and feel.") {
                    expect(sut) == snapshot("MovieDetailsView")
                }
            }
            
            context("when is on favorites list") {
                beforeEach {
                    viewModel.favorite = true
                    
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
