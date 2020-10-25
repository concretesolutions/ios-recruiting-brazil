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

    func getMovies(request: MoviesModels.MoviesItems.Request) {
        worker.getMovies(language: request.language, page: request.page) { result in
            switch result {
            case let .success(response):
                let responseModel = MoviesModels.MoviesItems.Response(moviesResponse: response)
                self.presenter.presentMoviesItems(response: responseModel)
            case let .failure(error):
                print(error.errorDescription)
                self.presenter.presentLoadMoviesFailure()
            }
        }
    }
}
