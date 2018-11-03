//
//  DefaultMovieDetailsSpec.swift
//  MovTests
//
//  Created by Miguel Nery on 03/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Quick
import Nimble

@testable import Mov

class DefaultMovieDetailsInteractorSpec: QuickSpec {
    override func spec() {
        describe("MovieDetails interacor") {
            var interactor: DefaultMovieDetailsInteractor!
            
            context("when initialized") {
                var presenter: MovieDetailsPresenterMock!
                var persistence: FavoritesPersistenceMock!
                beforeEach {
                    presenter = MovieDetailsPresenterMock()
                    persistence = FavoritesPersistenceMock()
                    interactor = DefaultMovieDetailsInteractor(presenter: presenter, persistence: persistence)
                }
                
                context("and getDetails of a movie") {
                    let movie = Movie.mock(id: 0)
                    let expectedUnit = MovieDetailsUnit(fromMovie: movie, isFavorite: false, genres: [])
                    beforeEach {
                        interactor.getDetails(of: movie)
                    }
                    
                    it("should present details") {
                        expect(presenter.didCall(method: .presentDetails)).to(beTrue())
                    }
                    
                    it("should send valid arguments to presenter") {
                        expect(presenter.receivedUnit).to(equal(expectedUnit))
                    }
                }
                
                context("and succeed to toggle favorite") {
                    let movie = Movie.mock(id: 0)
                    beforeEach {
                        persistence.raiseOnToggle = false
                        interactor.toggleFavorite(movie)
                    }
                    
                    it("present updated movie") {
                        expect(presenter.didCall(method: .presentDetails)).to(beTrue())
                    }
                }
                
                context("and fail to toggle favorite") {
                    let movie = Movie.mock(id: 0)
                    beforeEach {
                        persistence.raiseOnToggle = true
                        interactor.toggleFavorite(movie)
                    }
                    
                    it("should present movies") {
                        expect(presenter.didCall(method: .presentFavoritesError)).to(beTrue())
                    }
                }
            }
        }
    }
}
