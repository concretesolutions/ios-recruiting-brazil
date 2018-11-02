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
                var persistence: FavoritesPersistenceMock!
                var presenter: MovieGridPresenterMock!
                
                beforeEach {
                    movieFetcher = MovieFetcherMock()
                    persistence = FavoritesPersistenceMock()
                    presenter = MovieGridPresenterMock()
                    
                    interactor = DefaultMovieGridInteractor(presenter: presenter, movieFetcher: movieFetcher, persistence: persistence)
                }
                    
                context("and succeed to fetch movies") {
                    
                    beforeEach {
                        movieFetcher.flawedFetch = false
                    }
                    
                    context("and succeed to fetchFavorites") {
                        var expectedUnits: [MovieGridUnit]!
                        
                        beforeEach {
                            persistence.raiseOnFetch = false
                            expectedUnits = movieFetcher.mockMovies.map { movie in
                                let isFavorite = try! persistence.fetchFavorites().contains(movie)
                                return MovieGridUnit(from: movie, isFavorite: isFavorite)
                            }
            
                            interactor.fetchMovieList(page: 1)
                        }
                        
                        it("present movies") {
                            expect(presenter.didCall(method: .presentMovies)).to(beTrue())
                        }
                        
                        it("send correctly to presenter all data fetched") {
                            
                            expect(presenter.receivedUnits).to(equal(expectedUnits))
                        }
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



