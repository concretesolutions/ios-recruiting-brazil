//
//  FavoritesPresenter.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol FavoritesPresentationLogic: AnyObject {
    func presentFetchedLocalMovies(response: Favorites.FetchLocalMovies.Response)
    func presentFetchedLocalMoviesEmpty()
    func presenterMovieUnfavorite()
    func presentGenericFailure()
    func presentFetchedMoviesBySearch(response: Favorites.FetchLocalMoviesBySearch.Response)
    func presentSearchedMoviesFailure(filter: FilterSearch)
}

final class FavoritesPresenter: FavoritesPresentationLogic {
    weak var viewController: FavoritesDisplayLogic?

    // MARK: - FavoritesPresentationLogic conforms

    func presentFetchedLocalMovies(response: Favorites.FetchLocalMovies.Response) {
        let viewModel = Favorites.FetchLocalMovies.ViewModel(movies: response.movies)
        viewController?.displayLocalMovies(viewModel: viewModel)
    }

    func presentFetchedLocalMoviesEmpty() {
        viewController?.displayFetchedLocalMoviesEmpty()
    }

    func presenterMovieUnfavorite() {
        viewController?.displayMovieUnfavorite()
    }

    func presentGenericFailure() {
        viewController?.displayGenericError()
    }

    func presentFetchedMoviesBySearch(response: Favorites.FetchLocalMoviesBySearch.Response) {
        let viewModel = Favorites.FetchLocalMoviesBySearch.ViewModel(movies: response.movies)
        viewController?.displayMoviesBySearch(viewModel: viewModel)
    }

    func presentSearchedMoviesFailure(filter: FilterSearch) {
        let search = filter.search ?? .empty
        let date = filter.date?.joined(separator: Constants.Utils.genresSeparator) ?? .empty
        let genres = filter.genres?.joined(separator: Constants.Utils.genresSeparator) ?? .empty
        let searchText = search + .space + date + .space + genres
        viewController?.displaySearchError(searchedText: searchText)
    }
}
