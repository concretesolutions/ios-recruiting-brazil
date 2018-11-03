//
//  FavoritesPresenterSpec.swift
//  MovTests
//
//  Created by Miguel Nery on 02/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble

@testable import Mov

class FavoritesPresenterSpec: QuickSpec {
    override func spec() {
        describe("Favorites presenter") {
            var presenter: DefaultFavoritesPresenter!
            
            context("when initialized") {
                var viewOutput: FavoritesViewOutputMock!
                
                beforeEach {
                    viewOutput = FavoritesViewOutputMock()
                    presenter = DefaultFavoritesPresenter(viewOutput: viewOutput)
                }
                
                context("and present movies") {
                    let mockMovies = (0..<5).map {Movie.mock(id: $0)}
                    let mockUnits = mockMovies.map {FavoritesUnit(from: $0)}
                    let expectedViewModels = mockUnits.map { FavoritesViewModel(from: $0) }
                    
                    beforeEach {
                        presenter.present(movies: mockUnits)
                    }
                    
                    it("should display movies") {
                        expect(viewOutput.didCall(method: .displayMovies)).to(beTrue())
                    }
                    
                    it("should send valid arguments to viewOutput") {
                        expect(viewOutput.receivedViewModels).to(equal(expectedViewModels))
                    }
                }
                
                context("and present no results for search") {
                    let searchRequest = "movieTitle"
                    
                    beforeEach {
                        presenter.presentNoResultsFound(for: searchRequest)
                    }
                    
                    it("should display no results") {
                        expect(viewOutput.didCall(method: .displayNoResultsFound)).to(beTrue())
                    }
                    
                    it("should send valid arguments to viewOutput") {
                        expect(viewOutput.receivedRequest).to(equal(searchRequest))
                    }
                }
                
                context("and present fetch error") {
                    beforeEach {
                        presenter.presentFetchError()
                    }
                    
                    it("should display getch error") {
                        expect(viewOutput.didCall(method: .displayFetchError)).to(beTrue())
                    }
                }
                
                context("and present favoritesError") {
                    beforeEach {
                        presenter.presentFavoritesError()
                    }
                    
                    it("should display favorites error") {
                        expect(viewOutput.didCall(method: .displayFavoritesError)).to(beTrue())
                    }
                }
            }
        }
    }
}
