//
//  FavoriteMovieTableViewCellSpec.swift
//  moviesUITests
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class FavoriteMovieTableViewCellSpec: QuickSpec {
    override func spec() {
        var sut: FavoriteMovieTableViewCell!

        describe("the 'Favorite Movie Cell' ") {
            let movie = MockedDataProvider.shared.popularMovies.first!
            
            context("when fetched from API ") {
                beforeEach {
                    let viewModel = FavoriteMovieCellViewModel(of: movie)
                    
                    sut = FavoriteMovieTableViewCell()
                    sut.setViewModel(viewModel)
                    sut.frame = CGRect(x: 0, y: 0, width: 500, height: 125)
                }
                
                it("should have the expected look and feel.") {
                    expect(sut) == snapshot("MovieCellOnFavoriteMovies")
                }
                
            }
        }
    }
}
