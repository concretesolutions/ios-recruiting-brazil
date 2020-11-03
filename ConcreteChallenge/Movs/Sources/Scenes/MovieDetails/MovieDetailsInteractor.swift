//
//  MovieDetailsInteractor.swift
//  Movs
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MovieDetailsBusinessLogic: AnyObject {
    func saveMovie(request: MovieDetails.SaveMovie.Request)
    func deleteMovie(request: MovieDetails.DeleteMovie.Request)
}

final class MovieDetailsInteractor: MovieDetailsBusinessLogic {
    private let worker: RealmWorkerProtocol
    private let presenter: MovieDetailsPresentationLogic

    // MARK: - Initializers

    init(worker: RealmWorkerProtocol, presenter: MovieDetailsPresenter) {
        self.worker = worker
        self.presenter = presenter
    }

    // MARK: - MovieDetailsBusinessLogic conforms

    func saveMovie(request: MovieDetails.SaveMovie.Request) {
        worker.saveMovie(movie: request.movie) { result in
            switch result {
            case .success():
                self.presenter.onSaveMovieSuccessful()
            case let .failure(error):
                print(error.errorDescription)
                self.presenter.onSaveMovieFailure()
            }
        }
    }

    func deleteMovie(request: MovieDetails.DeleteMovie.Request) {
        worker.deleteMovie(movie: request.movie) { result in
            switch result {
            case .success():
                self.presenter.onDeleteMovieSuccessful()
            case let .failure(error):
                print(error.errorDescription)
                self.presenter.onDeleteMovieFailure()
            }
        }
    }
}
