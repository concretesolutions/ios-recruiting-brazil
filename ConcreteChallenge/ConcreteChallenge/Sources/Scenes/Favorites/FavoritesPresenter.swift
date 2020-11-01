//
//  FavoritesPresenter.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol FavoritesPresentationLogic: AnyObject {
    func presentLocalMoviesItems(response: Favorites.FetchLocalMovies.Response)
    func presentFetchMoviesFailure()
    func onSuccessDeleteMovie()
}

final class FavoritesPresenter: FavoritesPresentationLogic {
    weak var viewController: FavoritesDisplayLogic?

    // MARK: - FavoritesPresentationLogic conforms

    func presentLocalMoviesItems(response: Favorites.FetchLocalMovies.Response) {
        let viewModel = Favorites.FetchLocalMovies.ViewModel(movies: response.movies)
        viewController?.onFetchLocalMoviesSuccess(viewModel: viewModel)
    }

    func presentFetchMoviesFailure() {
        viewController?.displayMoviesError()
    }

    func onSuccessDeleteMovie() {
        viewController?.onSuccessDeleteMovie()
    }
}
