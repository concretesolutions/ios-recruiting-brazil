//
//  MovieGridSpec.swift
//  FAKTests
//
//  Created by Miguel Nery on 24/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble


@testable import Mov

class DefaultMovieGridInteractorSpec: QuickSpec {
    
    override func spec() {
        describe("the movie grid interactor") {
            let movieFethcer = MovieFetcherMock()
            let presenter = MovieGridPresenterMock()
            let moviePersistence = MoviePersistenceMock()
            
            let interactor = DefaultMovieGridInteractor(presenter: presenter, movieFetcher: movieFethcer, moviePersistence: moviePersistence)
            
            context("when succeed to fetch movies") {

                beforeEach {
                    movieFethcer.flawedFetch = false
                    interactor.fetchMovieList(page: 1)
                }
                
                it("call presenter's presentMovies") {
                    expect(presenter.didCall(method: .presentMovies)).to(beTrue())
                }
                
                it("send correctly to presenter all data fetched") {
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
                    interactor.fetchMovieList(page: 1)
                }
                
                it("call presenter's presentNetworkError") {
                    expect(presenter.didCall(method: .presentNetworkError)).to(beTrue())
                }
                
                afterEach {
                    presenter.resetMock()
                }
            }
        }
    }
}



