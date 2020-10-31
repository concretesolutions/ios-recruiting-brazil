//
//  MovieDetailsInteractor.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class MovieDetailsInteractor: MovieDetailsBusinessLogic {
    private let worker: MovieDetailsWorkerProtocol
    private let presenter: MovieDetailsPresentationLogic

    // MARK: - Initializers

    init(worker: MovieDetailsWorkerProtocol, presenter: MovieDetailsPresenter) {
        self.worker = worker
        self.presenter = presenter
    }

    // MARK: - MovieDetailsBusinessLogic conforms

    func saveMovie(request: MovieDetails.SaveMovie.Request) {
        worker.saveMovie(movie: request.movie) { result in
            switch result {
            case .success():
                let response = request.movie
                response.isFavorite = true

                self.presenter.onSuccessSaveMovie(response: MovieDetails.SaveMovie.Response(movie: response))
            case let .failure(error):
                self.presentFailure(error: error)
            }
        }
    }

    func deleteMovie(request: MovieDetails.DeleteMovie.Request) {
        worker.deleteMovie(movie: request.movie) { result in
            switch result {
            case .success():
                let response = request.movie
                response.isFavorite = false

                self.presenter.onSuccessDeleteMovie(response: MovieDetails.DeleteMovie.Response(movie: response))
            case let .failure(error):
                self.presentFailure(error: error)
            }
        }
    }

    // MARK: - Private functions

    private func presentFailure(error: DatabaseError) {
        print(error.errorDescription)
    }
}
