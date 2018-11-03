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
        describe("MovieGrid interactor") {
            
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
                
                context("and filter movies") {
                    var filterRequest: String!
                    
                    context("with a empty string") {
                        beforeEach {
                            filterRequest = ""
                            interactor.filterMoviesBy(string: filterRequest)
                        }
                        
                        it("should present movies") {
                            expect(presenter.didCall(method: .presentMovies)).to(beTrue())
                        }
                    }
                    
                    context("with a valid movie title") {
                        beforeEach {
                            interactor.fetchMovieList(page: 1) // to have fetched movies in memory
                            filterRequest = interactor.fetchedMovies[0].title
                            interactor.filterMoviesBy(string: filterRequest)
                        }
                        
                        it("should present movies") {
                            expect(presenter.didCall(method: .presentMovies)).to(beTrue())
                        }
                    }
                    
                    context("with a non existing movie title") {
                        beforeEach {
                            filterRequest = "434279AUAHEUAHE9H397H397HAUHA8E9A8E"
                            interactor.filterMoviesBy(string: filterRequest)
                        }
                        
                        it("should present no results") {
                            expect(presenter.didCall(method: .presentNoResultsFound)).to(beTrue())
                        }
                    }
                }
                
                context("and is asked a movie") {
                    var movieIndex: Int!
                    beforeEach {
                        interactor.fetchMovieList(page: 1) // to have fetched movies in memory
                    }
                    
                    context("with valid index") {
                        beforeEach {
                            movieIndex = 0
                        }
                        
                        it("should return a movie") {
                            expect(interactor.movie(at: movieIndex)).notTo(beNil())
                        }
                    }
                    
                    context("with invalid index") {
                        beforeEach {
                            movieIndex = -1
                        }
                        
                        it("should return nil") {
                            expect(interactor.movie(at: movieIndex)).to(beNil())
                        }
                    }
                }
            }
        }
    }
}



