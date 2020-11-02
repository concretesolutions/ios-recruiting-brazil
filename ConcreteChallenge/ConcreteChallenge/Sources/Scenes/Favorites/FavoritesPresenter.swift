//
//  FavoritesPresenter.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol FavoritesPresentationLogic: AnyObject {
    func presentLocalMoviesItems(response: Favorites.FetchLocalMovies.Response)
    func presentLocalMoviesBySearch(response: Favorites.FetchLocalMoviesBySearch.Response)
    func presentFetchMoviesFailure()
    func presentLocalMoviesBySearchFailure(response: Favorites.FetchLocalMoviesBySearch.Response)
    func onSuccessDeleteMovie()
}

final class FavoritesPresenter: FavoritesPresentationLogic {
    weak var viewController: FavoritesDisplayLogic?

    // MARK: - FavoritesPresentationLogic conforms

    func presentLocalMoviesItems(response: Favorites.FetchLocalMovies.Response) {
        let viewModel = Favorites.FetchLocalMovies.ViewModel(movies: response.movies)
        viewController?.onFetchLocalMoviesSuccess(viewModel: viewModel)
    }

    func presentLocalMoviesBySearch(response: Favorites.FetchLocalMoviesBySearch.Response) {
        let viewModel = Favorites.FetchLocalMoviesBySearch.ViewModel(movies: response.movies)
        viewController?.onFetchLocalMoviesBySearchSuccess(viewModel: viewModel)
    }

    func presentFetchMoviesFailure() {
        viewController?.displayMoviesError()
    }

    func presentLocalMoviesBySearchFailure(response: Favorites.FetchLocalMoviesBySearch.Response) {
        viewController?.displaySearchError(searchText: response.search.search ?? .empty)
    }

    func onSuccessDeleteMovie() {
        viewController?.onSuccessDeleteMovie()
    }
}
