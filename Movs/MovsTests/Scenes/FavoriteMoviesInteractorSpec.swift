//
//  FavoriteMoviesInteractorSpec.swift
//  MovsTests
//
//  Created by Maisa on 02/11/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class FavoriteMoviesInteractorSpec: QuickSpec {
    
    override func spec() {
        
        describe("FavoriteMoviesInteractor") {
            
            var presenter: FavoriteMoviesPresenterSpy!
            var interactor: FavoriteMoviesInteractor!

            context("when initializing") {
                
                beforeEach {
                    presenter = FavoriteMoviesPresenterSpy()
                    interactor = FavoriteMoviesInteractor()
                }
                
                it("Presenter should conforms to protocol FavoriteMoviesPresentationLogic"){
                    expect(presenter).to(beAKindOf(FavoriteMoviesPresentationLogic.self))
                }
                
                it("Interactor to have a valid image base path"){
                    expect(interactor.imageBasePath).to(equal("http://image.tmdb.org/t/p/w185"))
                }
                
                context("when listing favorite movies") {
                    
                    context("succeeded") {
                        
                        let expectedFormattedResponse = [FavoriteMoviesModel.FavoriteMovie(id: 123, title: "title", overview: "overview", posterPath: URL(string: "aaa")!, year: "2018"),
                                                FavoriteMoviesModel.FavoriteMovie(id: 666, title: "hell", overview: "overview", posterPath: URL(string: "aaa")!, year: "2018")]
                        
                        beforeEach {
                            let favoriteMovies: [MovieDetailed] = FavoriteMoviesWorkerMock.shared.getFavoriteMovies()
                            let formattedMovies = favoriteMovies.map { rawMovie in
                                FavoriteMoviesModel.FavoriteMovie(id: rawMovie.id, title: rawMovie.title, overview: rawMovie.overview, posterPath: URL(string: rawMovie.posterPath)!, year: String.getYearRelease(fullDate: rawMovie.releaseDate))
                            }
                            
                            let response = FavoriteMoviesModel.Response.Success(movies: formattedMovies)
                            presenter.presentMovies(response: response)
                            
                        }
                        
                        it("should return movies") {
                            expect(presenter.presentMoviesCalled).to(beTrue())
//                            expect(presenter.moviesToBePresented).to(equal(expectedFormattedResponse))
                        }
                    }
                    
                    context("failed") {
                        beforeEach {
                            let movies = FavoriteMoviesWorkerMock.shared.getFavoriteMoviesEmpty()
                            if movies.isEmpty {
                                let response = FavoriteMoviesModel.Response.Error(title: "Nenhum favorito", description: "Que tal iniciar a sua lista? Abra os detalhes de um filme e favorite-o.")
                                presenter.presentError(response: response)
                            }
                        }
                        
                        it("should return error message") {
                            expect(presenter.presentErrorCalled).to(beTrue())
                            expect(presenter.moviesToBePresented).to(beEmpty())
                        }
                    }
                }
                
                
                context("when removing a movie") {
                    beforeEach {
                        let response = FavoriteMoviesWorkerMock.shared.removeFavoriteMovie(id: 123)
                        if !response {
                            let response = FavoriteMoviesModel.Response.Error(title: "Erro", description: "Não foi possível remover o filme")
                            presenter.presentError(response: response)
                        }
                    }
                    
                    it("and succeeded") {
                        expect(presenter.presentErrorCalled).to(beFalse())
                    }
                }
                
                context("when removing a movie") {
                    beforeEach {
                        // Passing an id that doesn't exist
                        let response = FavoriteMoviesWorkerMock.shared.removeFavoriteMovie(id: 999)
                        if !response {
                            let response = FavoriteMoviesModel.Response.Error(title: "Erro", description: "Não foi possível remover o filme")
                            presenter.presentError(response: response)
                        }
                    }
                    
                    it("and failed") {
                        expect(presenter.presentErrorCalled).to(beTrue())
                    }
                }
                
                
            }
            
            
        }
        
    }
    
}

// MARK: - Presentation logic
final class FavoriteMoviesPresenterSpy: FavoriteMoviesPresentationLogic {
    
    var presentMoviesCalled = false
    var presentErrorCalled = false
    var moviesToBePresented: [FavoriteMoviesModel.FavoriteMovie]?
 
    func presentMovies(response: FavoriteMoviesModel.Response.Success) {
        presentMoviesCalled = true
        moviesToBePresented = response.movies
    }
    
    func presentError(response: FavoriteMoviesModel.Response.Error) {
        presentErrorCalled = true
        moviesToBePresented = []
    }
    
    
}
