//
//  MoviesPresenter.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MoviesPresentationLogic: AnyObject {
    func presentLocalMoviesItems(response: Movies.FetchLocalMovies.Response)
    func presentLocalMoviesBySearch(response: Movies.FetchLocalMoviesBySearch.Response)
    func presentGenresItems(response: Movies.FetchGenres.Response)
    func presentMoviesItems(response: Movies.FetchMovies.Response)
    func presentFetchMoviesFailure()
}

final class MoviesPresenter: MoviesPresentationLogic {
    weak var viewController: MoviesDisplayLogic?

    // MARK: - MoviesPresentationLogic conforms

    func presentLocalMoviesItems(response: Movies.FetchLocalMovies.Response) {
        let viewModel = Movies.FetchLocalMovies.ViewModel(movies: response.movies)
        viewController?.onFetchLocalMoviesSuccessful(viewModel: viewModel)
    }

    func presentLocalMoviesBySearch(response: Movies.FetchLocalMoviesBySearch.Response) {
        let viewModel = Movies.FetchLocalMoviesBySearch.ViewModel(movies: response.movies)

        if viewModel.movies.count > 0 {
            viewController?.displayMoviesBySearch(viewModel: viewModel)
        } else {
            viewController?.displaySearchError(textSearched: "")
        }
    }

    func presentGenresItems(response: Movies.FetchGenres.Response) {
        let viewModel = Movies.FetchGenres.ViewModel(genres: response.genres)
        viewController?.onFetchGenresSuccessful(viewModel: viewModel)
    }

    func presentMoviesItems(response: Movies.FetchMovies.Response) {
        let movies = response.moviesResponse.map { movieResponse -> Movie in
            let genreLabels = movieResponse.genreIds.map { id -> String in
                let genre = response.genres.first { genre -> Bool in
                    genre.id == id
                }

                return genre?.name ?? .empty
            }

            let genres = genreLabels.count > 0 ? genreLabels.joined(separator: Constants.Utils.genresSeparator) : nil

            return Movie(id: movieResponse.id, title: movieResponse.title, imageURL: Constants.MovieNetwork.baseImageURL.appending(movieResponse.imageURL), genres: genres, releaseDate: movieResponse.releaseDate.year, overview: movieResponse.overview, isFavorite: false)
        }

        let viewModel = Movies.FetchMovies.ViewModel(page: response.page, totalPages: response.totalPages, movies: movies)
        viewController?.displayMovies(viewModel: viewModel)
    }

    func presentFetchMoviesFailure() {
        viewController?.displayGenericError()
    }
}
