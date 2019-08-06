//
//  FavoriteMoviesPresenterSpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 05/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class FavoriteMoviesPresenterSpec: QuickSpec {
    override func spec() {
        var sut: FavoriteMoviesPresenter!
        var view: FavoriteMoviesViewMock!
        var interactor: FavoriteMoviesUseCaseMock!
        var router: FavoriteMoviesWireframeMock!
        var movie: MovieEntity!
        
        beforeEach {
            sut = FavoriteMoviesPresenter()
            view = FavoriteMoviesViewMock()
            interactor = FavoriteMoviesUseCaseMock()
            router = FavoriteMoviesWireframeMock()
            movie = MovieEntityMock.createMovieEntityInstance()
            
            sut.view = view
            sut.interactor = interactor
            sut.router = router
            UserSaves().add(movie: movie)
        }
        
        describe("Movie search") {
            context("If search is empty", {
                it("Has to show movies without filters", closure: {
                    let input = ""
                    sut.didEnterSearch(input)
                    guard let sutView = sut.view as? FavoriteMoviesViewMock
                        else {
                            fail()
                            return
                    }
                    expect(sutView.hasCalledShowFavoriteMoviesList).to(beTrue())
                })
            })
            context("If search finds movies", closure: {
                it("Has to send filtered movies to view with show movies list", closure: {
                    let input = "Lion"
                    sut.didEnterSearch(input)
                    guard let sutView = sut.view as? FavoriteMoviesViewMock
                        else {
                            fail()
                            return
                    }
                    expect(sutView.hasCalledShowFavoriteMoviesList).to(beTrue())
                })
            })
        }
        
        describe("Delete favorite movie") {
            it("Has to delete selected movie from favorites", closure: {
                UserSaves().add(movie: movie)
                
                sut.didDeleteFavorite(movie: movie)
                
                let movies = UserSaves().getAllFavoriteMovies()
                let result = movies.contains(where: { (mov) -> Bool in
                    mov.id == movie.id
                })
                
                expect(result).to(beFalse())
            })
        }
        
        context("If a movie cell is clicked") {
            it("Has to call screen transition from router", closure: {
                sut.didSelectMovie(movie, poster: nil)
                guard let sutRouter = sut.router as? FavoriteMoviesWireframeMock
                    else {
                        fail()
                        return
                }
                expect(sutRouter.hasCalledPresentFavoriteMovieDescription).to(beTrue())
            })
        }
        
        context("If user wants to use filters") {
            it("Has to call screen transition from router", closure: {
                sut.didPressFilter()
                guard let sutRouter = sut.router as? FavoriteMoviesWireframeMock
                    else {
                        fail()
                        return
                }
                expect(sutRouter.hasCalledPresentFilterSelection).to(beTrue())
            })
        }
        
    }
}
