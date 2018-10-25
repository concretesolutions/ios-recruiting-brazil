//
//  MovieGridSpec.swift
//  FAKTests
//
//  Created by Miguel Nery on 24/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble
import XCTest


@testable import Mov

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
                    expect(presenter.calledAlone(method: .presentMovies)).to(beTrue())
                }
                
                it("pass correctly all data fetched") {
                    let fetchedMoviesMock = movieFethcer.mockMovies.map { movie in
                        return MovieGridUnit(title: movie.title, posterPath: movie.posterPath, isFavorite: false)
                    }
                    
                    expect(presenter.receivedMovies).to(equal(fetchedMoviesMock))
                }
                
                afterEach {
                    presenter.resetMock()
                }
            }
            
            context("when fail to fetch movies"){
                
                beforeEach {
                    movieFethcer.flawedFetch = true
                    interactor.fetchMovieList()
                }
                
                it("call presenter's presentNetworkError only") {
                    expect(presenter.calledAlone(method: .presentNetworkError)).to(beTrue())
                }
                
                afterEach {
                    presenter.resetMock()
                }
            }
        }
    }
}



