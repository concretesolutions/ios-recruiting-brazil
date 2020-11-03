//
//  FavoritesInteractor.swift
//  Movs
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

                if localMovies.count > 0 {
                    let responseModel = Favorites.FetchLocalMovies.Response(movies: localMovies)
                    self.presenter.presentFetchedLocalMovies(response: responseModel)
                } else {
                    self.presenter.presentFetchedLocalMoviesEmpty()
                }
            case let .failure(error):
                self.presentGenericFailure(error: error)
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
                    if !allDates.localizedCaseInsensitiveContains(movie.releaseDate) {
                        return false
                    }
                }

                var moviesHasAllgenres = true
                if let genres = filter.genres {
                    genres.forEach({ genre in
                        if movie.genres == nil {
                            moviesHasAllgenres = false
                            return
                        } else if let movieGenres = movie.genres, !movieGenres.localizedCaseInsensitiveContains(genre) {
                            moviesHasAllgenres = false
                            return
                        }
                    })
                }

                if !moviesHasAllgenres {
                    return false
                }

                if let search = filter.search, !search.isEmpty {
                    return movie.title.localizedCaseInsensitiveContains(search)
                }

                return true
            })
        )

        if moviesFiltered.count > 0 {
            presenter.presentFetchedMoviesBySearch(response: Favorites.FetchLocalMoviesBySearch.Response(movies: moviesFiltered))
        } else {
            presenter.presentSearchedMoviesFailure(filter: filter)
        }
    }

    func deleteMovie(request: Favorites.DeleteMovie.Request) {
        worker.deleteMovie(movie: request.movie) { result in
            switch result {
            case .success():
                self.presenter.presenterMovieUnfavorite()
            case let .failure(error):
                self.presentGenericFailure(error: error)
            }
        }
    }

    // MARK: - Private functions

    private func presentGenericFailure(error: DatabaseError) {
        print(error.errorDescription)
        self.presenter.presentGenericFailure()
    }
}
