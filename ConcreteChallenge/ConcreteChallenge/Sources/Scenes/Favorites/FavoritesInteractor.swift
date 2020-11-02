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

        var moviesFiltered: [Movie] = []

        if let date = filter.date {
            let date = date.joined(separator: Constants.Utils.genresSeparator)

            moviesFiltered.append(contentsOf:
                movies.filter { date.contains($0.releaseDate) }
            )
        }

        if let genres = filter.genres {
            genres.forEach({ genre in
                moviesFiltered.append(contentsOf:
                    movies.filter({ movie -> Bool in
                        if moviesFiltered.contains(movie) {
                            return false
                        }

                        return movie.genres?.contains(genre) ?? false
                    })
                )
            })
        }

        if let search = filter.search {
            moviesFiltered.append(contentsOf:
                movies.filter {
                    if moviesFiltered.contains($0) {
                        return false
                    }

                    return $0.title.contains(search)
                }
            )
        }

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
