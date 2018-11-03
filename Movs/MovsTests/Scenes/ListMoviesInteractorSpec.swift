//
//  ListMoviesWorkerSpec.swift
//  MovsTests
//
//  Created by Maisa on 02/11/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class ListMoviesInteractorSpec: QuickSpec {

    override func spec() {
        describe("ListMoviesInteractor") {
            // Main object
            var interactor: ListMoviesInteractor!
            
            var presenter: MoviesListPresenterSpy!
            var worker: ListMoviesWorkerMock?
            
            context("when initializing") {
                beforeEach {
                    interactor = ListMoviesInteractor()
                    worker = ListMoviesWorkerMock()
                    presenter = MoviesListPresenterSpy()
                    
                    interactor.presenter = presenter
                }
                
                it("Worker should conforms to protocol ListMoviesWorkerProtocol"){
                    expect(worker).to(beAKindOf(ListMoviesWorkerProtocol.self))
                }
                
                it("Presenter should conforms to protocol ListMoviesPresentationLogic"){
                    expect(presenter).to(beAKindOf(ListMoviesPresentationLogic.self))
                }
                
                it("Interactor to have a valid image base path"){
                    expect(interactor.imageBasePath).to(equal("http://image.tmdb.org/t/p/w185"))
                }
                
                context("and fetching popular movies") {
                    
                    context("and succeeded") {
                        beforeEach {
                            let request = ListMovies.Request(page: 1)
                            worker?.fetchPopularMovies(request: request, success: { (movie) in
                                
                                let response = ListMovies.Response.Success(movies: movie.movies)
                                presenter.presentMovies(response: response)
                                
                            }, error: { (error) in },
                               failure: { (networkError) in })
                        }
                        
                        it("in receive movies from Worker") {
                            expect(presenter.presentMoviesCalled).to(beTrue())
                        }
                    }
                    
                    context("and it failed") {
                        beforeEach {
                            let request = ListMovies.Request(page: 0)
                            worker?.fetchPopularMovies(request: request, success: { (movie) in },
                                                       
                                 error: { (error) in
                                 let responseError = ListMovies.Response.Error(image: nil, description: "", errorType: FetchError.serverError)
                                 presenter.presentError(error: responseError)
                                    
                            },failure: { (networkError) in })
                        }
                        
                        it("and received a Server Error") {
                            expect(presenter.presentErrorCalled).to(equal(FetchError.serverError))
                        }
                    }
                    
                    context("and it failed") {
                        beforeEach {
                            worker?.error = FetchError.networkFailToConnect
                            let request = ListMovies.Request(page: 1)
                            worker?.fetchPopularMovies(request: request, success: { (movie) in },
                                                       error: { (error) in },
                            failure: { (networkError) in
                                
                                let responseError = ListMovies.Response.Error(image: nil, description: "", errorType: FetchError.networkFailToConnect)
                                presenter.presentError(error: responseError)
                                
                            })
                        }
                        
                        it("and received a Network Error") {
                            expect(presenter.presentErrorCalled).to(equal(FetchError.networkFailToConnect))
                        }
                    }
                }
                
                
            }

        }
    }
    
}
// MARK: - Presentation logic
final class MoviesListPresenterSpy: ListMoviesPresentationLogic {
    
    var presentMoviesCalled = false
    var presentErrorCalled: FetchError?
    var moviesToBePresented: [PopularMovie]?
    
    func presentMovies(response: ListMovies.Response.Success) {
        presentMoviesCalled = true
        moviesToBePresented = response.movies
    }
    
    func presentError(error: ListMovies.Response.Error) {
        presentErrorCalled = error.errorType
    }
    
}
