//
//  MovieDetailsPresenter.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class MovieDetailsPresenter: MovieDetailsPresentationLogic {
    weak var viewController: MovieDetailsDisplayLogic?

    // MARK: - MovieDetailsPresentationLogic conforms

    func onSuccessSaveMovie(response: MovieDetails.SaveMovie.Response) {
        let viewModel = MovieDetails.SaveMovie.ViewModel(movie: response.movie)
        viewController?.onSuccessSaveMovie(viewModel: viewModel)
    }

    func onSuccessDeleteMovie(response: MovieDetails.DeleteMovie.Response) {
        let viewModel = MovieDetails.DeleteMovie.ViewModel(movie: response.movie)
        viewController?.onSuccessDeleteMovie(viewModel: viewModel)
    }
}
