//
//  MovieGridSpec.swift
//  FAKTests
//
//  Created by Miguel Nery on 24/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble

@testable import FAK

class MovieGridInteractorSpec: QuickSpec {
    
    override func spec() {
        describe("the movie grid interactor") {
            let movieFethcer = MovieFetcherMock()
            let presenter = MovieGridPresenterMock()
            let interactor = DefaultMovieGridInteractor(presenter: presenter, movieFetcher: movieFethcer)
            
            context("when succeed to fetch movies") {

                beforeEach {
                    movieFethcer.flawedFetch = false
                    interactor.fetchMovieList()
                }
                
                
                it("call presenter's presentMovies only") {
                    expect(presenter.calledOnly(method: .presentMovies)).to(beTrue())
                }
                
                afterEach {
                    presenter.clearCalls()
                }
            }
            
            context("when fail to fetch movies"){
                
                beforeEach {
                    movieFethcer.flawedFetch = true
                    interactor.fetchMovieList()
                }
                
                it("call presenter's presentNetworkError only") {
                    expect(presenter.calledOnly(method: .presentNetworkError)).to(beTrue())
                }
                
                afterEach {
                    presenter.clearCalls()
                }
            }
        }
    }
}



