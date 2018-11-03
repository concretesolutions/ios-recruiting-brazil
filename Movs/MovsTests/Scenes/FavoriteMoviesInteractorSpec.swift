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
            var worker: ManageFavoriteMoviesActions!
            
            context("when initializing"){
                beforeEach {
                    presenter = FavoriteMoviesPresenterSpy()
                    worker = FavoriteMoviesWorkerMock()
                }
                
                context("and listing favorite movies") {
                    
                    context("succeeded") {
                        
                        let expectedFormattedResponse = [FavoriteMoviesModel.FavoriteMovie(id: 123, title: "title", overview: "overview", posterPath: URL(string: "aaa")!, year: "2018"),
                                                FavoriteMoviesModel.FavoriteMovie(id: 666, title: "hell", overview: "overview", posterPath: URL(string: "aaa")!, year: "2018")]
                        
                        beforeEach {
                            let favoriteMovies: [MovieDetailed] = worker.getFavoriteMovies()
                            let formattedMovies = favoriteMovies.map { rawMovie in
                                FavoriteMoviesModel.FavoriteMovie(id: rawMovie.id, title: rawMovie.title, overview: rawMovie.overview, posterPath: URL(string: rawMovie.posterPath)!, year: String.getYearRelease(fullDate: rawMovie.releaseDate))
                            }
                            
                            let response = FavoriteMoviesModel.Response.Success(movies: formattedMovies)
                            presenter.presentMovies(response: response)
                            
                        }
                        
                        it("should return movies") {
                            expect(presenter.presentMoviesCalled).to(beTrue())
                            expect(presenter.moviesToBePresented).to(equal(expectedFormattedResponse))
                        }
                    }
                    
                    context("failed") {
                        beforeEach {
                            let response = FavoriteMoviesModel.Response.Error(title: "Nenhum favorito", description: "Que tal iniciar a sua lista? Abra os detalhes de um filme e favorite-o.")
                            presenter.presentError(response: response)
                        }
                        
                        it("should return error message") {
                            expect(presenter.presentErrorCalled).to(beTrue())
                        }
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
    }
    
    
}
