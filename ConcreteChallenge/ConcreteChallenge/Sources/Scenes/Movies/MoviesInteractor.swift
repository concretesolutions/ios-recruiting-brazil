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

    func fetchGenres(request: Movies.FetchGenres.Request) {
        worker.fetchGenres(language: request.language) { result in
            switch result {
            case let .success(response):
                let responseModel = Movies.FetchGenres.Response(genres: response.genres)
                self.presenter.presentGenresItems(response: responseModel)
            case let .failure(error):
                self.presentFailure(error: error)
            }
        }
    }

    func fetchMovies(request: Movies.FetchMovies.Request) {
        worker.fetchMovies(language: request.language, page: request.page) { result in
            switch result {
            case let .success(response):
                let movies = response.movies.map { movie -> Movie in
                    let genreLabels = movie.genreIds.map { id -> String in
                        let genre = request.genres.first { genre -> Bool in
                            genre.id == id
                        }

                        return genre?.name ?? .empty
                    }

                    return Movie(id: movie.id, title: movie.title, imageURL: Constants.MovieNetwork.baseImageURL.appending(movie.imageURL), genreIds: movie.genreIds, overview: movie.overview, releaseDate: movie.releaseDate, genreLabels: genreLabels)
                }

                let responseModel = Movies.FetchMovies.Response(page: response.page, totalPages: response.totalPages, movies: movies)
                self.presenter.presentMoviesItems(response: responseModel)
            case let .failure(error):
                self.presentFailure(error: error)
            }
        }
    }

    // MARK: - Private functions

    private func presentFailure(error: NetworkError) {
        print(error.errorDescription)
        self.presenter.presentFetchMoviesFailure()
    }
}
