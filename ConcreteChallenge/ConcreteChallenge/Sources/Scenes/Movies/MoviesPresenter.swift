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
    func presentFetchedMovies(response: Movies.FetchMovies.Response)
    func presentFetchFailure()
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

    func presentFetchedGenres(response: Movies.FetchGenres.Response) {
        let viewModel = Movies.FetchGenres.ViewModel(genres: response.genres)
        viewController?.onFetchGenresSuccessful(viewModel: viewModel)
    }

    func presentFetchedMovies(response: Movies.FetchMovies.Response) {
        let viewModel = Movies.FetchMovies.ViewModel(page: response.page, totalPages: response.totalPages, movies: response.movies)
        viewController?.displayMovies(viewModel: viewModel)
    }

    func presentFetchFailure() {
        viewController?.displayGenericError()
    }

    func presentLocalMoviesBySearch(response: Movies.FetchLocalMoviesBySearch.Response) {
        let viewModel = Movies.FetchLocalMoviesBySearch.ViewModel(movies: response.movies)
        viewController?.displayMoviesBySearch(viewModel: viewModel)
    }

    func presentSearchMoviesFailure(textSearched: String) {
        viewController?.displaySearchError(textSearched: textSearched)
    }
}
