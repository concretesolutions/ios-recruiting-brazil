//
//  MovieListInteractorSpec.swift
//  MovsTests
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class MovieListInteractorSpec: QuickSpec {
    override func spec() {
        describe("MovieListInteractor Spec") {
            
            var interactor: MovieListInteractor!
            var viewController: MovieListViewController!
            
            context("init interactor") {
                
                beforeEach {
                    let presenter = MovieListPresenterStub()
                    interactor = MovieListInteractor()
                    interactor.presenter = presenter
                }
                
                it("should have all workers") {
                    expect(interactor.coreDataWorker).toNot(beNil())
                    expect(interactor.movieListWorker).toNot(beNil())
                    expect(interactor.presenter).toNot(beNil())
                }
                
                it("should have enter error") {
                    let request = MovieList.Request.Page(page: 0)
                    interactor.fetchMovies(request: request)
                    expect(interactor.movies.count).to(equal(0))
                }
                
                it("should store movie") {
                    let movie = Movie(id: 0, genreIds: [], posterPath: "",
                                      overview: "", releaseDate: "", title: "")
                    interactor.movies.append(movie)
                    interactor.storeMovie(at: 0)
                    expect(interactor.movie).toNot(beNil())
                }
                
            }
            
            context("interactor from viewController") {
                
                beforeEach {
                    let movie = Movie(id: 0, genreIds: [],
                                      posterPath: "", overview: "",
                                      releaseDate: "", title: "Movie")
                    viewController = MovieListViewController()
                    interactor = viewController.interactor as? MovieListInteractor
                    interactor.movies = [movie]
                }
                
                it("should let view controller on display state") {
                    let request = MovieList.Request.Movie(title: "Movie")
                    interactor.filterMovies(request: request)
                    expect(viewController.stateMachine.currentState).to(beAKindOf(MovieListDisplayState.self))
                }
            }
        }
    }
}

