//
//  MoviesPresenter.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MoviesPresentationLogic: AnyObject {
    func presentFetchedLocalMovies(response: Movies.FetchLocalMovies.Response)
    func presentFetchedGenres(response: Movies.FetchGenres.Response)
    func presentFetchedMovies(response: Movies.FetchMovies.Response)
    func presentFetchedFailure()
    func presentFetchedMoviesBySearch(response: Movies.FetchLocalMoviesBySearch.Response)
    func presentSearchedMoviesFailure(textSearched: String)
}

final class MoviesPresenter: MoviesPresentationLogic {
    weak var viewController: MoviesDisplayLogic?

    // MARK: - MoviesPresentationLogic conforms

    func presentFetchedLocalMovies(response: Movies.FetchLocalMovies.Response) {
        let viewModel = Movies.FetchLocalMovies.ViewModel(movies: response.movies)
        viewController?.onFetchedLocalMovies(viewModel: viewModel)
    }

    func presentFetchedGenres(response: Movies.FetchGenres.Response) {
        let viewModel = Movies.FetchGenres.ViewModel(genres: response.genres)
        viewController?.onFetchedGenres(viewModel: viewModel)
    }

    func presentFetchedMovies(response: Movies.FetchMovies.Response) {
        let viewModel = Movies.FetchMovies.ViewModel(page: response.page, totalPages: response.totalPages, movies: response.movies)
        viewController?.displayMovies(viewModel: viewModel)
    }

    func presentFetchedFailure() {
        viewController?.displayGenericError()
    }

    func presentFetchedMoviesBySearch(response: Movies.FetchLocalMoviesBySearch.Response) {
        let viewModel = Movies.FetchLocalMoviesBySearch.ViewModel(movies: response.movies)
        viewController?.displayMoviesBySearch(viewModel: viewModel)
    }

    func presentSearchedMoviesFailure(textSearched: String) {
        viewController?.displaySearchError(searchedText: textSearched)
    }
}
