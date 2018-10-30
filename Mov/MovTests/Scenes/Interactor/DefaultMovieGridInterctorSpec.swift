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
            
            var interactor: DefaultMovieGridInteractor!
            
            context("when initialized") {
                var movieFetcher: MovieFetcherMock!
                var moviePersistence: MoviePersistenceMock!
                var presenter: MovieGridPresenterMock!
                
                beforeEach {
                    movieFetcher = MovieFetcherMock()
                    moviePersistence = MoviePersistenceMock()
                    presenter = MovieGridPresenterMock()
                    
                    interactor = DefaultMovieGridInteractor(presenter: presenter, movieFetcher: movieFetcher, persistence: moviePersistence)
                }
                    
                context("and succeed to fetch movies") {
                    var fetchedMoviesMock: [MovieGridUnit]!
                    
                    beforeEach {
                        fetchedMoviesMock = movieFetcher.mockMovies.map { movie in
                            return MovieGridUnit(title: movie.title, posterPath: movie.posterPath, isFavorite: false)
                        }
                        
                        movieFetcher.flawedFetch = false
                        interactor.fetchMovieList(page: 1)
                    }
                    
                    it("present movies") {
                        expect(presenter.didCall(method: .presentMovies)).to(beTrue())
                    }
                    
                    it("send correctly to presenter all data fetched") {

                        expect(presenter.receivedMovies).to(equal(fetchedMoviesMock))
                    }
                }
                
                context("and fail to fetch movies") {
                    
                    beforeEach {
                        movieFetcher.flawedFetch = true
                        interactor.fetchMovieList(page: 1)
                    }
                    
                    it("present presentNetworkError") {
                        expect(presenter.didCall(method: .presentNetworkError)).to(beTrue())
                    }
                }
            }
        }
    }
}



