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
                    movie.favorite = false

                    let viewModel = MovieDetailsViewModel(of: movie)
                    let frame = UIScreen.main.bounds
                    
                    sut = MovieDetailsViewControllerScreen(with: viewModel, frame: frame)
                    
                }
                
                it("should have the expected look and feel.") {
                    expect(sut) == recordSnapshot("MovieDetailsView")
                }
            }
            
            context("when is on favorites list") {
                beforeEach {
                    movie.favorite = true

                    let viewModel = MovieDetailsViewModel(of: movie)
                    let frame = UIScreen.main.bounds
                    
                    sut = MovieDetailsViewControllerScreen(with: viewModel, frame: frame)
                    
                }
                
                it("should have the expected look and feel.") {
                    expect(sut) == recordSnapshot("MovieDetailsView_Favorite")
                }
            }
        }
    }
}
