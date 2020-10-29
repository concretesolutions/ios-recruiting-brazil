//
//  MoviesInteractor.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class MoviesInteractor: MoviesBusinessLogic {
    private let moyaWorker: MoviesMoyaWorkerProtocol
    private let realmWorker: MoviesRealmWorkerProtocol
    private let presenter: MoviesPresentationLogic

    // MARK: - Initializers

    init(moyaWorker: MoviesMoyaWorkerProtocol, realmWorker: MoviesRealmWorkerProtocol, presenter: MoviesPresentationLogic) {
        self.moyaWorker = moyaWorker
        self.realmWorker = realmWorker
        self.presenter = presenter
    }

    // MARK: - MoviesInteractor conforms

    func fetchMovies(request: Movies.FetchMovies.Request) {
        moyaWorker.fetchMovies(language: request.language, page: request.page) { result in
            switch result {
            case let .success(response):
                let movies = response.movies.map { movie -> Movie in
                    Movie(id: movie.id, title: movie.title, imageURL: Constants.MovieNetwork.baseImageURL.appending(movie.imageURL))
                }

                let responseModel = Movies.FetchMovies.Response(moviesResponse: MoviesPopulariesResponse(page: response.page, totalPages: response.totalPages, movies: movies))
                self.presenter.presentMoviesItems(response: responseModel)
            case let .failure(error):
                print(error.errorDescription)
                self.presenter.presentFetchMoviesFailure()
            }
        }
    }
}
