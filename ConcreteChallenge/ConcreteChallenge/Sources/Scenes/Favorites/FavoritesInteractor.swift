//
//  FavoritesInteractor.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol FavoritesBusinessLogic: AnyObject {
    func fetchLocalMovies()
    func fetchLocalMoviesBySearch(request: Favorites.FetchLocalMoviesBySearch.Request)
    func deleteMovie(request: Favorites.DeleteMovie.Request)
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

    func fetchLocalMoviesBySearch(request: Favorites.FetchLocalMoviesBySearch.Request) {
        let movies = request.movies
        let filter = request.filter
        let allDates = filter.date?.joined(separator: Constants.Utils.genresSeparator)

        var moviesFiltered: [Movie] = []

        moviesFiltered.append(contentsOf:
            movies.filter({ movie -> Bool in
                if let allDates = allDates {
                    if !allDates.contains(movie.releaseDate) {
                        return false
                    }
                }

                var moviesHasAllgenres = true
                if let genres = filter.genres {
                    genres.forEach({ genre in
                        if let movieGenres = movie.genres, !movieGenres.contains(genre) {
                            moviesHasAllgenres = false
                            return
                        } else {
                            moviesHasAllgenres = false
                            return
                        }
                    })
                }

                if !moviesHasAllgenres {
                    return false
                }

                if let search = filter.search, !search.isEmpty {
                    return movie.title.contains(search)
                }

                return true
            })
        )

        if moviesFiltered.count > 0 {
            presenter.presentLocalMoviesBySearch(response: Favorites.FetchLocalMoviesBySearch.Response(movies: moviesFiltered, search: filter))
        } else {
            presenter.presentLocalMoviesBySearchFailure(response: Favorites.FetchLocalMoviesBySearch.Response(movies: moviesFiltered, search: filter))
        }
    }

    func deleteMovie(request: Favorites.DeleteMovie.Request) {
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
