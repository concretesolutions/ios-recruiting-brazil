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
            var movie = MockedDataProvider.shared.popularMovies.first!
            
            context("when fetched from API ") {
                context("and is not on favorites list ") {
                    beforeEach {
                        movie.favorite = false

                        let viewModel = MovieCellViewModel(of: movie)
                        
                        sut = MovieCollectionViewCell(with: viewModel)
                        sut.frame = CGRect(x: 0, y: 0, width: 250, height: 375)
                    }
                    
                    it("should have the expected look and feel.") {
                        expect(sut) == snapshot("MovieCellOnMovieList")
                    }
                }
                
                context("and is on favorites list ") {
                    beforeEach {
                        movie.favorite = true

                        let viewModel = MovieCellViewModel(of: movie)
                        
                        sut = MovieCollectionViewCell(with: viewModel)
                        sut.frame = CGRect(x: 0, y: 0, width: 250, height: 375)
                    }
                    
                    it("should have the expected look and feel.") {
                        expect(sut) == snapshot("MovieCellOnMovieList_Favorite")
                    }
                }
            }
        }
    }
}

