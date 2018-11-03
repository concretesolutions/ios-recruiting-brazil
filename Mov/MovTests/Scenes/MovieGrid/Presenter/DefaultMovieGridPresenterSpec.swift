//
//  DefaultMovieGridPresenterSpec.swift
//  MovTests
//
//  Created by Miguel Nery on 26/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble

@testable import Mov

class DefaultMovieGridPresenterSpec: QuickSpec {
    override func spec() {
        describe("MovieGrid presenter") {
            var presenter: DefaultMovieGridPresenter!
            
            context("when initialized") {
                var viewOutput: MovieGridViewOutPutMock!
                
                beforeEach {
                    viewOutput = MovieGridViewOutPutMock()
                    presenter = DefaultMovieGridPresenter(viewOutput: viewOutput)
                }
                
                context("and present movies") {
                    let unitsMock = (0..<5).map { MovieGridUnit(title: String($0), posterPath: "", isFavorite: false) }
                    
                    let expectedViewModels = unitsMock.map { unit in
                        return MovieGridViewModel(title: unit.title, posterPath: unit.posterPath, isFavoriteIcon: Images.isFavoriteIconGray)
                    }
                    
                    beforeEach {
                        presenter.present(movies: unitsMock)
                    }
                    
                    it("display movies") {
                        expect(viewOutput.didCall(method: .displayMovies)).to(beTrue())
                    }
                    
                    it("send correctly to viewOutput the data to be displayed") {
                        expect(viewOutput.receivedViewModels).to(equal(expectedViewModels))
                    }
                }
                
                context("and present network error") {
                    beforeEach {
                        presenter.presentNetworkError()
                    }
                    
                    it("display networkError") {
                        expect(viewOutput.didCall(method: .displayNetworkError)).to(beTrue())
                    }
                }
                
                context("and present no results found") {
                    let searchRequest = "movieTitle"
                    
                    beforeEach {
                        presenter.presentNoResultsFound(for: searchRequest)
                    }
                    
                    it("should display no results found") {
                        expect(viewOutput.didCall(method: .displayNoResults)).to(beTrue())
                    }
                    
                    it("shouls send correct request to viewOutput") {
                        expect(viewOutput.receivedResultRequest).to(equal(searchRequest))
                    }
                }
                
                context("and present favoritesError") {
                    beforeEach {
                        presenter.presentGenericError()
                    }
                    
                    it("should display favorites error") {
                        expect(viewOutput.didCall(method: .displayFavoritesError)).to(beTrue())
                    }
                }
            }
        }
    }
}

