//
//  MovieCollectionViewCellSpec.swift
//  moviesUITests
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import movies

class MovieCollectionViewCellSpec: QuickSpec {
    override func spec() {
        var sut: MovieCollectionViewCell!

        describe("the 'Movie Cell' ") {
            let movie = MockedDataProvider.shared.popularMovies.first!
            let viewModel = MovieCellViewModel(of: movie)
            let frame = CGRect(x: 0, y: 0, width: 250, height: 375)
            
            context("when fetched from API ") {
                context("and is not on favorites list ") {
                    beforeEach {
                        viewModel.favorite = false
                        
                        sut = MovieCollectionViewCell(frame: frame)
                        sut.setViewModel(viewModel)
                    }
                    
                    it("should have the expected look and feel.") {
                        expect(sut) == snapshot("MovieCellOnMovieList")
                    }
                }
                
                context("and is on favorites list ") {
                    beforeEach {
                        viewModel.favorite = true
                        
                        sut = MovieCollectionViewCell(frame: frame)
                        sut.setViewModel(viewModel)
                    }
                    
                    it("should have the expected look and feel.") {
                        expect(sut) == snapshot("MovieCellOnMovieList_Favorite")
                    }
                }
            }
        }
    }
}

