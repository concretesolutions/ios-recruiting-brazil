//
//  DetailMoviesInteractorSpec.swift
//  MovsTests
//
//  Created by Maisa on 03/11/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class DetailMoviesInteractorSpec: QuickSpec {
    
    override func spec() {
        describe("DetailMoviesInteractor") {
            
            var interactor: DetailMoviesInteractor!
            var presenter: DetailMoviesPresenterSpy!
            var worker: DetailMovieWorkerMock!
            
            context("when initializing") {
                beforeEach {
                    interactor = DetailMoviesInteractor()
                    presenter = DetailMoviesPresenterSpy()
                    worker = DetailMovieWorkerMock()
                    
                    interactor.presenter = presenter
                    interactor.worker = worker
                }
                
                it("Worker should conforms to protocol DetailMovieWorkerProtocol"){
                    expect(worker).to(beAKindOf(DetailMovieWorkerProtocol.self))
                }
                
                it("Presenter should conforms to protocol DetailMoviesPresentationLogic"){
                    expect(presenter).to(beAKindOf(DetailMoviesPresentationLogic.self))
                }
                
                it("Presenter should conforms to protocol FavoriteActionsPresentationLogic"){
                    expect(presenter).to(beAKindOf(FavoriteActionsPresentationLogic.self))
                }
                
                it("Interactor should conforms to protocol DetailMoviesBusinessLogic"){
                    expect(interactor).to(beAKindOf(DetailMoviesBusinessLogic.self))
                }

            }
            
            context("when fetching detailed movie") {
                context("and succeeded") {
                    beforeEach {
                        let request = DetailMovieModel.Request(movieId: 123)
                        worker.getMovieDetails(request: request,
                                               success: { (movie) in
                                                
                        let response = DetailMovieModel.Response.Success(movie: movie)
                        presenter.presentMovieDetailed(response: response)
                                                
                        }, error: { (error) in },
                           failure: { (networkError) in })
                    }
                    
                    it("in receive movie detailed from Worker") {
                        expect(presenter.presentMovieCalled).to(beTrue())
                    }
                }
                
                context("and it failed") {
                    beforeEach {
                        let request = DetailMovieModel.Request(movieId: 666)
                        worker.getMovieDetails(request: request,
                                               success: { (movie) in },
                                               error: { (error) in
                                                
                        let errorMessage = "\(error.getTitle()). \(error.getDescription())"
                        let responseError = DetailMovieModel.Response.Error(image: UIImage(named: "alert_search"), message: errorMessage)
                        presenter.presentError(error: responseError)
                                                
                        },
                        failure: { (networkError) in })
                    }
                    
                    it("and received a Server Error") {
                        expect(presenter.presentErrorCalled).to(beTrue())
                        expect(presenter.presentImageForError).to(beTrue())
                    }
                }
                
                context("and it failed") {
                    beforeEach {
                        let request = DetailMovieModel.Request(movieId: 666)
                        worker.getMovieDetails(request: request,
                                               success: { (movie) in },
                                               error: { (error) in },
                                               failure: { (networkError) in
                            
                            let errorMessage = "\(networkError.getTitle()). \(networkError.getDescription())"
                            let responseError = DetailMovieModel.Response.Error(image: UIImage(named: "alert_error"), message: errorMessage)
                            presenter.presentError(error: responseError)
                                                
                        })
                    }
                    
                    it("and received a Network Error") {
                        expect(presenter.presentErrorCalled).to(beTrue())
                        expect(presenter.presentImageForError).to(beTrue())
                    }
                }
            }
            
            context("when favoriting a movie") {
  
                context("and succeeded") {
                    
                    beforeEach {
                        let movieDetailed = MovieDetailed(id: 333, genres: [Genre(id: 23, name: "genre")], genresNames: ["genre"], title: "title", overview: "overview", releaseDate: "2018-10-10", posterPath: "aaa", voteAverage: 8.0, isFavorite: false)
                        let addFavoriteResult: Bool = FavoriteMoviesWorkerMock.shared.addFavoriteMovie(movie: movieDetailed)
                        if addFavoriteResult {
                            presenter.favoriteActionSuccess(message: "Filme adicionado à lista de favoritos ✨")
                        }
                    }
                    
                    it("so movie is now a favorite") {
                        expect(presenter.successMessage).to(beTrue())
//                        expect(presenter.favoriteResultMessage).to(beTrue())
                    }
                }
                
                context("and failed ") {
                    beforeEach {
                        let movieDetailed = MovieDetailed(id: 123, genres: [Genre(id: 23, name: "genre")], genresNames: ["genre"], title: "title", overview: "overview", releaseDate: "2018-10-10", posterPath: "aaa", voteAverage: 8.0, isFavorite: false)
                        let addFavoriteResult: Bool = FavoriteMoviesWorkerMock.shared.addFavoriteMovie(movie: movieDetailed)
                        if !addFavoriteResult {
                            presenter.favoriteActionError(message: "Problemas ao adicionar filme à lista de favoritos")
                        }
                    }
                    
                    it("because the movie is already a favorite") {
                        expect(presenter.successMessage).to(beFalse())
//                        expect(presenter.favoriteResultMessage).to(equal("Problemas ao adicionar filme à lista de favoritos"))
                    }
                }
            }
            
        }
        

    }

}

// MARK: - Presentation logic
final class DetailMoviesPresenterSpy: DetailMoviesPresentationLogic, FavoriteActionsPresentationLogic {

    // MARK: - Detail Movies
    var presentMovieCalled = false
    var presentErrorCalled = false
    var movieToBePresented: MovieDetailed?
    var presentImageForError = false
    
    func presentMovieDetailed(response: DetailMovieModel.Response.Success) {
        presentMovieCalled = true
        movieToBePresented = response.movie
    }
    
    func presentError(error: DetailMovieModel.Response.Error) {
        presentErrorCalled = true
        if error.image == UIImage(named: "alert_search") || error.image ==  UIImage(named: "alert_error") {
            presentImageForError = true
        }
    }
    
    // MARK: - Favorite actions
    var successMessage = false
    var favoriteResultMessage = ""
    
    func favoriteActionSuccess(message: String) {
        successMessage = true
        favoriteResultMessage = message
    }
    
    func favoriteActionError(message: String) {
        successMessage = false
    }
    
    func favoriteRemove(message: String) {
        successMessage = true
    }
 
}
