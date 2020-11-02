//
//  MoviesInteractor.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MoviesBusinessLogic: AnyObject {
    func fetchLocalMovies()
    func fetchGenres(request: Movies.FetchGenres.Request)
    func fetchMovies(request: Movies.FetchMovies.Request)
    func fetchLocalMoviesBySearch(request: Movies.FetchLocalMoviesBySearch.Request)
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
                self.presenter.presentFetchedLocalMovies(response: responseModel)
            case let .failure(error):
                self.presentGenericFailure(error: error)
            }
        }
    }

    func fetchGenres(request: Movies.FetchGenres.Request) {
        moyaWorker.fetchGenres(language: request.language) { result in
            switch result {
            case let .success(response):
                let responseModel = Movies.FetchGenres.Response(genres: response.genres)
                self.presenter.presentFetchedGenres(response: responseModel)
            case let .failure(error):
                self.presentGenericFailure(error: error)
            }
        }
    }

    func fetchMovies(request: Movies.FetchMovies.Request) {
        moyaWorker.fetchMovies(language: request.language, page: request.page) { result in
            switch result {
            case let .success(response):
                let movies = response.moviesResponse.map { movieResponse -> Movie in
                    let genreLabels = movieResponse.genreIds.map { id -> String in
                        let genre = request.genres.first { genre -> Bool in
                            genre.id == id
                        }

                        return genre?.name ?? .empty
                    }

                    let genres = genreLabels.count > 0 ? genreLabels.joined(separator: Constants.Utils.genresSeparator) : nil

                    return Movie(id: movieResponse.id, title: movieResponse.title, imageURL: Constants.MovieNetwork.baseImageURL.appending(movieResponse.imageURL), genres: genres, releaseDate: movieResponse.releaseDate.year, overview: movieResponse.overview, isFavorite: false)
                }

                let responseModel = Movies.FetchMovies.Response(page: response.page, totalPages: response.totalPages, movies: movies)
                self.presenter.presentFetchedMovies(response: responseModel)
            case let .failure(error):
                self.presentGenericFailure(error: error)
            }
        }
    }

    func fetchLocalMoviesBySearch(request: Movies.FetchLocalMoviesBySearch.Request) {
        guard !request.filter.isEmpty else {
            return
        }

        let movies = request.movies.filter { $0.title.localizedCaseInsensitiveContains(request.filter) }

        if movies.count > 0 {
            presenter.presentFetchedMoviesBySearch(response: Movies.FetchLocalMoviesBySearch.Response(movies: movies))
        } else {
            presenter.presentSearchedMoviesFailure(textSearched: request.filter)
        }
    }

    // MARK: - Private functions

    private func presentGenericFailure(error: NetworkError) {
        print(error.errorDescription)
        self.presenter.presentFetchedFailure()
    }

    private func presentGenericFailure(error: DatabaseError) {
        print(error.errorDescription)
        self.presenter.presentFetchedFailure()
    }
}
