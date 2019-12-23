//
//  DefaultMoviesListViewModelSpecs.swift
//  ConcreteChallengeTests
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import ConcreteChallenge

class DefaultMoviesListViewModelSpecs: QuickSpec {
    override func spec() {
        var moviesListViewModel: MoviesListViewModel!
        let movie = Movie(
            id: 1, title: "title", posterPath: nil, backdropPath: nil,
            isAdult: nil, overview: nil, releaseDate: nil, genreIDs: []
        )
        
        beforeEach {
            moviesListViewModel = DefaultMoviesListViewModelSpecs.defaultMovieListViewModel()
        }

        describe("user is look for movies") {
            context("a change in a movie happend in other view") {
                it("need to reload the movie view") {
                    moviesListViewModel = DefaultMoviesListViewModelSpecs.defaultMovieListViewModel(moviesReponse:
                        .pages([
                            .init(items: [movie], totalOfPages: 2, pageNumber: 1)
                        ]
                    ))
                    
                    var moviePosition: Int?
                    moviesListViewModel.needReloadMovieView = { position in
                        moviePosition = position
                    }
                    
                    moviesListViewModel.needReloadAllMovies = {
                        if moviesListViewModel.numberOfMovies > 0 {
                            moviesListViewModel.reloadMovie(movie)
                        }
                    }
                    
                    moviesListViewModel.thePageReachedTheEnd()
                    expect(moviePosition).toEventually(equal(0))
                }
                it("need to delete the movie view") {
                    moviesListViewModel = DefaultMoviesListViewModelSpecs.defaultMovieListViewModel(moviesReponse:
                        .pages([
                            .init(items: [movie], totalOfPages: 2, pageNumber: 1)
                        ]
                    ))
                    
                    var moviePosition: Int?
                    moviesListViewModel.needDeleteMovieView = { position in
                        moviePosition = position
                    }
                    
                    moviesListViewModel.needReloadAllMovies = {
                        if moviesListViewModel.numberOfMovies > 0 {
                            moviesListViewModel.deleteMovie(movie)
                        }
                    }
                    
                    moviesListViewModel.thePageReachedTheEnd()
                    expect(moviePosition).toEventually(equal(0))
                }
                it("need to insert a movie view") {
                    moviesListViewModel = DefaultMoviesListViewModelSpecs.defaultMovieListViewModel(moviesReponse:
                        .pages([
                            .init(items: [movie], totalOfPages: 2, pageNumber: 1)
                        ]
                    ))
                    
                    var moviePosition: Int?
                    moviesListViewModel.needInsertMovieView = { position in
                        moviePosition = position
                    }
                    
                    moviesListViewModel.needReloadAllMovies = {
                        if moviesListViewModel.numberOfMovies > 0 {
                            moviesListViewModel.insertMovie(movie)
                        }
                    }
                    
                    moviesListViewModel.thePageReachedTheEnd()
                    expect(moviePosition).toEventually(equal(0))
                }
            }
            context("user tapped on a movie") {
                it("need tell the navitator about it") {
                    moviesListViewModel = DefaultMoviesListViewModelSpecs.defaultMovieListViewModel(moviesReponse:
                        .pages([
                            .init(items: [.init(
                                id: 1, title: "title", posterPath: nil, backdropPath: nil,
                                isAdult: nil, overview: nil, releaseDate: nil, genreIDs: [])],
                                totalOfPages: 2, pageNumber: 1)
                        ]
                    ))
                    let navigator = MockMoviesListViewModelNavigator()
                    moviesListViewModel.navigator = navigator
                    
                    var movieWasSelected = false
                    navigator.movieWasSelectedCompletion = {
                        movieWasSelected = true
                    }
                    moviesListViewModel.needReloadAllMovies = {
                        if moviesListViewModel.numberOfMovies > 0 {
                            moviesListViewModel.userSelectedMovie(atPosition: 0)
                        }
                    }
                    
                    moviesListViewModel.thePageReachedTheEnd()
                    expect(movieWasSelected).toEventually(equal(true))
                }
            }
            context("the moviesRepository returned a error") {
                it("need show the error to the user") {
                    moviesListViewModel = DefaultMoviesListViewModelSpecs.defaultMovieListViewModel(
                        moviesReponse: .error(MockError())
                    )
                    
                    var returnedError = false
                    moviesListViewModel.needShowError = { errorMessage in
                        returnedError = true
                    }
                    
                    moviesListViewModel.thePageReachedTheEnd()
                    expect(returnedError).toEventually(equal(true))
                }
            }
            context("the moviesRepository returned movies data") {
                it("need reload the view with new movies") {
                    moviesListViewModel = DefaultMoviesListViewModelSpecs.defaultMovieListViewModel(moviesReponse:
                        .pages([
                            .init(items: [], totalOfPages: 2, pageNumber: 1),
                            .init(items: [], totalOfPages: 2, pageNumber: 2)
                        ]
                    ))
                    var calledShowNewMovies = false
                    var calledReloadAll = false
                    moviesListViewModel.needReloadAllMovies = {
                        calledReloadAll = true
                    }
                    
                    moviesListViewModel.needShowNewMovies = { _ in
                        expect(calledReloadAll).to(equal(true))
                        
                        calledShowNewMovies = true
                    }
                    
                    moviesListViewModel.thePageReachedTheEnd()
                    moviesListViewModel.thePageReachedTheEnd()
                    
                    expect(calledReloadAll).toEventually(equal(true))
                    expect(calledShowNewMovies).toEventually(equal(true))
                }
            }
            context("the moviesRepository is loading the data") {
                it("show loading state") {
                    
                    var loadingWasCalled = false
                    var loadingHasFinished = false
                    moviesListViewModel.needChangeLoadingStateVisibility = { visible in
                        if !loadingWasCalled {
                            expect(visible).to(equal(true))
                            loadingWasCalled = true
                        } else {
                            expect(visible).to(equal(false))
                            loadingHasFinished = true
                        }
                    }
                    
                    moviesListViewModel.thePageReachedTheEnd()
                    expect(loadingHasFinished).toEventually(equal(true))
                }
            }
        }
        describe("user is scrolling over the movies") {
            context("and the last page was showed") {
                it("cannot load more movies") {
                    var currentPage = 0
                    
                    moviesListViewModel = DefaultMoviesListViewModelSpecs.defaultMovieListViewModel(
                        moviesReponse: .pages(
                            [
                                .init(items: [], totalOfPages: 2, pageNumber: 1),
                                .init(items: [], totalOfPages: 2, pageNumber: 2)
                            ]
                        ),
                        getMoviesCalledCompletion: {
                            currentPage += 1
                        }
                    )
                    
                    moviesListViewModel.thePageReachedTheEnd()
                    moviesListViewModel.thePageReachedTheEnd()
                    moviesListViewModel.thePageReachedTheEnd()
                    
                    expect(currentPage).toEventually(equal(2))
                }
            }
        }
    }

    private static func defaultMovieListViewModel(
        moviesReponse: MockMoviesRepository.MockResponse = .pages([Page<Movie>(items: [], totalOfPages: 1, pageNumber: 1)]),
        getMoviesCalledCompletion: (() -> Void)? = nil) -> MoviesListViewModel {
        
        let moviesRepository = MockMoviesRepository(response: moviesReponse)
        moviesRepository.getMoviesCalledCompletion = getMoviesCalledCompletion
        return DefaultMoviesListViewModel(moviesRepository: moviesRepository, presentations: [], emptyStateTitle: nil) { injectorData in
            switch injectorData {
            case .normal(let movie):
                return DefaultMovieViewModel(movie: movie, imageRepository: MockMovieImageRepository(response: .error(MockError())), genresRepository: MockGenresRepository(response: .error(MockError())))
            case .favorite(let movie):
                return DefaultMovieViewModel(movie: movie, imageRepository: MockMovieImageRepository(response: .error(MockError())), genresRepository: MockGenresRepository(response: .error(MockError())))
            }
            
        }
    }
}
