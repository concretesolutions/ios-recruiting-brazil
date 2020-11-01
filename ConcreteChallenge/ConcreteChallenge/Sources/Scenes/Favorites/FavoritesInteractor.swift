//
//  FavoritesInteractor.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol FavoritesBusinessLogic: AnyObject {
    func fetchLocalMovies()
    func deleteMovie(request: MovieDetails.DeleteMovie.Request)
}

final class FavoritesInteractor: FavoritesBusinessLogic {
    private let worker: RealmWorkerProtocol
    private let presenter: FavoritesPresentationLogic

    // MARK: - Initializers

    init(worker: RealmWorkerProtocol, presenter: FavoritesPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }

    // MARK: - FavoritesBusinessLogic conforms

    func fetchLocalMovies() {
        worker.fetchMovies() { result in
            switch result {
            case let .success(response):
                let localMovies = response.map { movie -> Movie in
                    movie.isFavorite = true
                    return movie
                }
                let responseModel = Favorites.FetchLocalMovies.Response(movies: localMovies)
                self.presenter.presentLocalMoviesItems(response: responseModel)
            case let .failure(error):
                self.presentFailure(error: error)
            }
        }
    }

    func deleteMovie(request: MovieDetails.DeleteMovie.Request) {
        worker.deleteMovie(movie: request.movie) { result in
            switch result {
            case .success():
                self.presenter.onSuccessDeleteMovie()
            case let .failure(error):
                self.presentFailure(error: error)
            }
        }
    }

    // MARK: - Private functions

    private func presentFailure(error: DatabaseError) {
        print(error.errorDescription)
        self.presenter.presentFetchMoviesFailure()
    }
}
