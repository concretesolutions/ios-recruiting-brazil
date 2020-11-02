//
//  MoviesInteractor.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MoviesBusinessLogic: AnyObject {
    func fetchLocalMovies()
    func fetchLocalMoviesBySearch(request: Movies.FetchLocalMoviesBySearch.Request)
    func fetchGenres(request: Movies.FetchGenres.Request)
    func fetchMovies(request: Movies.FetchMovies.Request)
}

final class MoviesInteractor: MoviesBusinessLogic {
    private let realmWorker: RealmWorkerProtocol
    private let moyaWorker: MoyaWorkerProtocol
    private let presenter: MoviesPresentationLogic

    // MARK: - Initializers

    init(realmWorker: RealmWorkerProtocol, moyaWorker: MoyaWorkerProtocol, presenter: MoviesPresentationLogic) {
        self.moyaWorker = moyaWorker
        self.realmWorker = realmWorker
        self.presenter = presenter
    }

    // MARK: - MoviesBusinessLogic conforms

    func fetchLocalMovies() {
        realmWorker.fetchMovies() { result in
            switch result {
            case let .success(response):
                let localMovies = response.map { movie -> Movie in
                    movie.isFavorite = true
                    return movie
                }
                let responseModel = Movies.FetchLocalMovies.Response(movies: localMovies)
                self.presenter.presentLocalMoviesItems(response: responseModel)
            case let .failure(error):
                self.presentFailure(error: error)
            }
        }
    }

    func fetchLocalMoviesBySearch(request: Movies.FetchLocalMoviesBySearch.Request) {
        if let search = request.filter.search, !search.isEmpty {
            let movies = request.movies.filter { $0.title.contains(search) }
            presenter.presentLocalMoviesBySearch(response: Movies.FetchLocalMoviesBySearch.Response(movies: movies, search: request.filter))
        }
    }

    func fetchGenres(request: Movies.FetchGenres.Request) {
        moyaWorker.fetchGenres(language: request.language) { result in
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
        moyaWorker.fetchMovies(language: request.language, page: request.page) { result in
            switch result {
            case let .success(response):
                let responseModel = Movies.FetchMovies.Response(page: response.page, totalPages: response.totalPages, genres: request.genres, moviesResponse: response.moviesResponse)
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

    private func presentFailure(error: DatabaseError) {
        print(error.errorDescription)
        self.presenter.presentFetchMoviesFailure()
    }
}
