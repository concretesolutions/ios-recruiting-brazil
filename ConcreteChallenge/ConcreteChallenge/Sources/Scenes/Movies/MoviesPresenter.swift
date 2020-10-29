//
//  MoviesPresenter.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class MoviesPresenter: MoviesPresentationLogic {
    weak var viewController: MoviesDisplayLogic?

    // MARK: - MoviesPresentationLogic conforms

    func presentMoviesItems(response: Movies.FetchMovies.Response) {
        let viewModel = Movies.FetchMovies.ViewModel(moviesResponse: response.moviesResponse)
        viewController?.displayMoviesItems(viewModel: viewModel)
    }

    func presentLoadMoviesFailure() {
        viewController?.displayMoviesError()
    }
}
