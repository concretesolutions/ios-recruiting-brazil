//
//  DefaultMovieDetailsPresenterSpec.swift
//  MovTests
//
//  Created by Miguel Nery on 03/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble

@testable import Mov

class DefaultMovieDetailsPresenterSpec: QuickSpec {
    override func spec() {
        describe("MovieDetails presenter") {
            var presenter: DefaultMovieDetailsPresenter!
            
            context("when initialized") {
                var viewOutput: MovieDetailsViewOutputMock!
                beforeEach {
                    viewOutput = MovieDetailsViewOutputMock()
                    presenter = DefaultMovieDetailsPresenter(viewOutput: viewOutput)
                }
                
                context("and present details") {
                    let mockUnit = MovieDetailsUnit(fromMovie: Movie.mock(id: 1), isFavorite: false, genres: [])
                    let expectedViewModel = MovieDetailsViewModel(from: mockUnit)
                    
                    beforeEach {
                        presenter.presentDetails(of: mockUnit)
                    }
                    
                    it("should display details") {
                        expect(viewOutput.didCall(method: .displayDetails)).to(beTrue())
                    }
                    
                    it("should send valid argumens to viwOutput") {
                        expect(viewOutput.receivedViewModel).to(equal(expectedViewModel))
                    }
                }
                
                context("and present favoritesError") {
                    beforeEach {
                        presenter.presentFavoritesError()
                    }
                    
                    it("should display favorites error") {
                        expect(viewOutput.didCall(method: .displayFavoritesErorr)).to(beTrue())
                    }
                }
            }
        }
    }
}
