//
//  DefaultFavoritesInteractorSpec.swift
//  MovTests
//
//  Created by Miguel Nery on 02/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble

@testable import Mov

class DefaultFavoritesInteractorSpec: QuickSpec {
    override func spec() {
        describe("Favorites interactor") {
            var interactor: DefaultFavoritesInteractor!
            
            context("when initialized") {
                var presenter: FavoritesPresenterMock!
                var persistence: FavoritesPersistenceMock!
                
                beforeEach {
                    presenter = FavoritesPresenterMock()
                    persistence = FavoritesPersistenceMock()
                    interactor = DefaultFavoritesInteractor(presenter: presenter, persistence: persistence)
                }
                
                context("and succeed to fetch favorites") {
                    var expectedUnits: [FavoritesUnit]!
                    
                    beforeEach {
                        persistence.raiseOnFetch = false
                        expectedUnits = persistence.mockMovies.map { FavoritesUnit(from: $0) }
                            
                        interactor.fetchFavorites()
                    }
                    
                    it("should present movies") {
                        expect(presenter.didCall(method: .presentMovies)).to(beTrue())
                    }
                    
                    it("should send valid arguments to presenter") {
                        expect(presenter.receivedUnits).to(equal(expectedUnits))
                    }
                }
                
                context("and fail to fetch favorites") {
                    beforeEach {
                        persistence.raiseOnFetch = true
                        interactor.fetchFavorites()
                    }
                    
                    it("should present error") {
                        expect(presenter.didCall(method: .presentFetchError)).to(beTrue())
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
                            interactor.fetchFavorites() // to have fetched movies in memory
                            filterRequest = interactor.favorites[0].title
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
                        interactor.fetchFavorites() // to have fetched movies in memory
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
                
                context("and succeed to toggle favorite") {
                    let validIndex = 0
                    beforeEach {
                        interactor.fetchFavorites()
                        persistence.raiseOnToggle = false
                        interactor.toggleFavoriteMovie(at: validIndex)
                    }
                    
                    it("should present movies") {
                        expect(presenter.didCall(method: .presentMovies)).to(beTrue())
                    }
                }
                
                context("and fail to toggle favorite") {
                    let validIndex = 0
                    beforeEach {
                        interactor.fetchFavorites()
                        persistence.raiseOnToggle = true
                        interactor.toggleFavoriteMovie(at: validIndex)
                    }
                    
                    it("should present movies") {
                        expect(presenter.didCall(method: .presentFavoritesError)).to(beTrue())
                    }
                }
                
            }
        }
    }
}
