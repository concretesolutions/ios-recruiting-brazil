//
//  FavoriteMoviesPresenterSpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 05/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble

@testable import Movs

class FavoriteMoviesPresenterSpec: QuickSpec {
    override func spec() {
        var sut: FavoriteMoviesPresenter!
        var view: FavoriteMoviesViewMock!
        var interactor: FavoriteMoviesUseCaseMock!
        var router: FavoriteMoviesWireframeMock!
        var movie: MovieEntity!
        var genres: GenresEntity!
        
        beforeEach {
            sut = FavoriteMoviesPresenter()
            view = FavoriteMoviesViewMock()
            interactor = FavoriteMoviesUseCaseMock()
            router = FavoriteMoviesWireframeMock()
            movie = MovieEntityMock.createMovieEntityInstance()
            genres = GenresEntityMock.createGenresEntityInstance()
            
            sut.view = view
            sut.interactor = interactor
            sut.router = router
            
            sut.favoriteMovies = []
            sut.posters = []
            GenresEntity.setAllGenres(genres.genres)
        }
        
        describe("Load") {
            context("If there is a filter", {
                it("has to show filtered movies", closure: {
                    sut.filteredMovies.append(movie)
                    sut.viewDidLoad()
                    guard let sutView = sut.view as? FavoriteMoviesViewMock
                        else {
                            fail()
                            return
                    }
                    expect(sutView.hasCalledShowFavoriteMoviesList).to(beTrue())
                })
            })
            context("If there is no filter", {
                it("has fetch data from interactor", closure: {
                    sut.viewDidLoad()
                    guard let sutInteractor = sut.interactor as? FavoriteMoviesUseCaseMock
                        else {
                            fail()
                            return
                    }
                    expect(sutInteractor.hasCalledFetchFavoriteMovies).to(beTrue())
                })
            })
            
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
            context("If there are favorite movies", closure: {
                it("Has to show movies at view", closure: {
                    sut.favoriteMovies.append(movie)
                    sut.didDeleteFavorite(movie: movie)
                    guard let sutView = sut.view as? FavoriteMoviesViewMock
                        else {
                            fail()
                            return
                    }
                    expect(sutView.hasCalledShowFavoriteMoviesList).to(beTrue())
                })
            })
            context("If there is no more favorite movies", {
                it("Has to call no content screen", closure: {
                    sut.didDeleteFavorite(movie: movie)
                    guard let sutView = sut.view as? FavoriteMoviesViewMock
                        else {
                            fail()
                            return
                    }
                    expect(sutView.hasCalledShowNoContentScreen).to(beTrue())
                })
                
            })
                
//                UserSaves().add(movie: movie)
//
//                sut.didDeleteFavorite(movie: movie)
//
//                let movies = UserSaves().getAllFavoriteMovies()
//                let result = movies.contains(where: { (mov) -> Bool in
//                    mov.id == movie.id
//                })
//
//                expect(result).to(beFalse())
           
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
        
        describe("Interactor sent favorite movies list") {
            context("If there are movies in list") {
                it("Has to show movies at view", closure: {
                    var movies: [MovieEntity]! = []
                    movies.append(movie)
                    var posters: [PosterEntity]! = []
                    posters.append(PosterEntity(poster: UIImage()))
                    sut.fetchedFavoriteMovies(movies, posters: posters)
                    
                    guard let sutView = sut.view as? FavoriteMoviesViewMock
                        else {
                            fail()
                            return
                    }
                    expect(sutView.hasCalledShowFavoriteMoviesList).to(beTrue())
                })
            }
            context("If there aren't movies in list") {
                it("Has to show no content screen", closure: {
                    let movies: [MovieEntity] = []
                    let posters: [PosterEntity] = []
                    sut.fetchedFavoriteMovies(movies, posters: posters)
                    
                    guard let sutView = sut.view as? FavoriteMoviesViewMock
                        else {
                            fail()
                            return
                    }
                    expect(sutView.hasCalledShowNoContentScreen).to(beTrue())
                })
            }
        }
        
        describe("Interactor failed to send data") {
            it("Has to show no content screen with error", closure: {
                sut.fetchedFavoriteMoviesFailed()
                
                guard let sutView = sut.view as? FavoriteMoviesViewMock
                    else {
                        fail()
                        return
                }
                expect(sutView.hasCalledShowNoContentScreen).to(beTrue())
            })
        }
        
    }
}
