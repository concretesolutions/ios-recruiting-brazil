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
        describe("the MovieGrid interactor") {
            let viewOutput = MovieGridViewOutPutMock()
            
            let presenter = DefaultMovieGridPresenter(viewOutput: viewOutput)
            
            let movieGridUnitsMock = (0..<5).map { movieTitle in
                return MovieGridUnit(title: String(movieTitle), posterPath: "", isFavorite: false)
            }
            
            context("when requested to present movies") {
                beforeEach {
                    presenter.present(movies: movieGridUnitsMock)
                }
                
                it("call viewOutput displayMovies") {
                    expect(viewOutput.didCall(method: .displayMovies)).to(beTrue())
                }
                
                it("send correctly to viewOutput the data to be displayed") {
                    let viewModelsMock = movieGridUnitsMock.map { unit in
                        return MovieGridViewModel(title: unit.title, poster: kImages.poster_placeholder, isFavoriteIcon: kImages.isFavoriteIconEmpty)
                    }
                    
                    expect(viewOutput.receivedViewModels).to(equal(viewModelsMock))
                }
                
                afterEach {
                    viewOutput.resetMock()                }
            }
            
            context("when requested to present a network error") {
                beforeEach {
                    presenter.presentNetworkError()
                }
                
                it("call viewOutput displayNetworkError") {
                    expect(viewOutput.didCall(method: .displayNetworkError)).to(beTrue())
                }
                
                afterEach {
                    viewOutput.resetMock()
                }
            }
        }
    }
}

