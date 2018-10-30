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
        describe("the MovieGrid presenter") {
            
            context("when initialized") {
                var viewOutput: MovieGridViewOutPutMock!
                var presenter: DefaultMovieGridPresenter!
                
                beforeEach {
                    viewOutput = MovieGridViewOutPutMock()
                    presenter = DefaultMovieGridPresenter(viewOutput: viewOutput)
                }
                
                context("and requested to present movies") {
                    let unitsMock = (0..<5).map { movieTitle in
                        return MovieGridUnit(title: String(movieTitle), posterPath: "", isFavorite: false)
                    }
                    
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
                
                context("and requested to present a network error") {
                    beforeEach {
                        presenter.presentNetworkError()
                    }
                    
                    it("display networkError") {
                        expect(viewOutput.didCall(method: .displayNetworkError)).to(beTrue())
                    }
                }
            }
        }
    }
}

