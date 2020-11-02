//
//  MoviesPresenter.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MoviesPresentationLogic: AnyObject {
    func presentFetchedLocalMovies(response: Movies.FetchLocalMovies.Response)
    func presentFetchedGenres(response: Movies.FetchGenres.Response)
    func presentMoviesItems(response: Movies.FetchMovies.Response)
    func presentFetchMoviesFailure()
    func presentLocalMoviesBySearch(response: Movies.FetchLocalMoviesBySearch.Response)
    func presentSearchMoviesFailure(textSearched: String)
}

final class MoviesPresenter: MoviesPresentationLogic {
    weak var viewController: MoviesDisplayLogic?

    // MARK: - MoviesPresentationLogic conforms

    func presentFetchedLocalMovies(response: Movies.FetchLocalMovies.Response) {
        let viewModel = Movies.FetchLocalMovies.ViewModel(movies: response.movies)
        viewController?.onFetchLocalMoviesSuccessful(viewModel: viewModel)
    }

    func presentLocalMoviesBySearch(response: Movies.FetchLocalMoviesBySearch.Response) {
        let viewModel = Movies.FetchLocalMoviesBySearch.ViewModel(movies: response.movies)

        if viewModel.movies.count > 0 {
            viewController?.displayMoviesBySearch(viewModel: viewModel)
        } else {
            viewController?.displaySearchError(textSearched: "")
        }
    }

    func presentFetchedGenres(response: Movies.FetchGenres.Response) {
        let viewModel = Movies.FetchGenres.ViewModel(genres: response.genres)
        viewController?.onFetchGenresSuccessful(viewModel: viewModel)
    }

    func presentMoviesItems(response: Movies.FetchMovies.Response) {
        let viewModel = Movies.FetchMovies.ViewModel(page: response.page, totalPages: response.totalPages, movies: response.movies)
        viewController?.displayMovies(viewModel: viewModel)
    }

    func presentFetchMoviesFailure() {
        viewController?.displayGenericError()
    }

    func presentSearchMoviesFailure(textSearched: String) {
        
    }
}
