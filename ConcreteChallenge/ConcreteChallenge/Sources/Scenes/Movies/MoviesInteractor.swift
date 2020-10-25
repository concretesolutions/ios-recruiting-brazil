//
//  MoviesInteractor.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class MoviesInteractor: MoviesBusinessLogic {
    private let worker: MoviesWorkerProtocol
    private let presenter: MoviesPresentationLogic

    // MARK: - Initializers

    init(worker: MoviesWorkerProtocol, presenter: MoviesPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }

    // MARK: - MoviesInteractor conforms

    func loadMovies(request: MoviesModels.MoviesItems.Request) {
        worker.loadMovies()

        let response = MoviesModels.MoviesItems.Response()
        presenter.presentMoviesItems(response: response)
    }
}
