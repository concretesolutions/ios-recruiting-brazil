//
//  MoviesThunk.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import RxSwift
import ReSwift
import ReSwiftThunk

class MovieThunk {
    static let disposeBag = DisposeBag()

    static func dependencyUpdated() -> Thunk<RootState> {
        return Thunk<RootState> { dispatch, getState in
            guard let state: RootState = getState() else { return }

            var movies: [Movie] = []

            do {
                for (key, movie) in state.movie.movies.enumerated() {
                    let genres = state.genre
                        .genres.filter({ movie.genreIds.contains($0.id) })
                        .map({ $0.name })
                    let favorited = state.favorites
                        .favorites.contains(where: { $0.id == movie.id })

                    if genres != movie.genres || favorited != movie.favorited {
                        movies.append(try movie.clone())
                    } else {
                        movies.append(movie)
                    }

                    movies[key].genres = genres
                    movies[key].favorited = favorited
                }

                if let currentMovieDetails = state.movie.currentMovieDetails {

                    if let detailedMovie = movies.first(where: { $0.id == currentMovieDetails.id }) {

                        let cloned = try currentMovieDetails.clone()

                        cloned.favorited = detailedMovie.favorited
                        cloned.genres = state.genre.genres.filter({ detailedMovie.genreIds.contains($0.id) })

                        DispatchQueue.main.async { dispatch(MovieActions.updateMovieDetails(cloned)) }
                    }
                }

                DispatchQueue.main.async {
                    dispatch(MovieActions.set(movies))
                }
            } catch {
                print("Error \(error)")
            }
        }
    }

    static func fetchDetails(of movieId: Int) -> Thunk<RootState> {
        return Thunk<RootState> { dispatch, getState in
            guard let state = getState(), !state.movie.loading, state.infra.isConnected else { return }

            var details: MovieDetails?

            if let movieMinimalDetails = state.movie.movies.first(where: { $0.id == movieId }) {
                details = MovieDetails(with: movieMinimalDetails)
            } else {
                if let favoriteMinimalDetails = state.favorites.favorites.first(where: { $0.id == movieId }) {
                    details = MovieDetails(with: favoriteMinimalDetails)
                }
            }

            if let details = details {
                DispatchQueue.main.async { dispatch(MovieActions.movieDetails(details)) }
            }

            MovieDetails.get(id: movieId)
                .subscribe(
                    onSuccess: { fullDetails in
                        DispatchQueue.main.async { dispatch(MovieActions.movieDetails(fullDetails)) }
                    },
                    onError: { _ in
                        DispatchQueue.main.async {
                            dispatch(MovieActions.requestError(message: "Erro ao carregar filme"))
                        }
                    }
                )
                .disposed(by: MovieThunk.disposeBag)
        }
    }

    static func search(filteringBy filters: MovieFilters) -> Thunk<RootState> {

        return Thunk<RootState> { dispatch, getState in
            guard let state = getState(), !state.movie.loading, state.infra.isConnected else { return }

            DispatchQueue.main.async {
                dispatch(
                    MovieActions.requestStated(isSearching: true, isPaginating: filters.page > 1)
                )
            }

            let endopoint = Endpoint<MovieResponse>(method: .get, path: "/search/movie", parameters: filters.parameters)

            Client.shared.request(endopoint)
                .subscribe(onSuccess: { data in
                    DispatchQueue.main.async {
                        dispatch(
                            MovieActions.addMovies(
                                data.results,
                                page: filters.page,
                                total: data.totalPages,
                                filters: filters
                            )
                        )
                    }
                }, onError: { error in
                    switch error {
                    case ApiError.conflict:
                        print("Conflict error")
                    case ApiError.forbidden:
                        print("Forbidden error")
                    case ApiError.notFound:
                        print("Not found error")
                    default:
                        print("Unknown error:", error)
                    }
                    DispatchQueue.main.async {
                        dispatch(
                            MovieActions.requestError(message: "Erro ao carregar filmes")
                        )
                    }
                })
                .disposed(by: MovieThunk.disposeBag)

        }
    }

    static func fetchPopular(at page: Int) -> Thunk<RootState> {

        return Thunk<RootState> { dispatch, getState in
            guard let state = getState(), !state.movie.loading, state.infra.isConnected else { return }

            DispatchQueue.main.async {
                dispatch(
                    MovieActions.requestStated(isSearching: false, isPaginating: page > 1)
                )

            }

            let parameters: Parameters = ["page": page]
            let endopoint = Endpoint<MovieResponse>(method: .get, path: "/movie/popular", parameters: parameters)

            Client.shared.request(endopoint)
                .subscribe(onSuccess: { data in
                     DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                         dispatch(
                             MovieActions.addMovies(
                                 data.results,
                                 page: data.page,
                                 total: data.totalPages,
                                 filters: MovieFilters()
                             )
                         )
                     }
                }, onError: { _ in
                    DispatchQueue.main.async {
                        dispatch(
                            MovieActions.requestError(message: "Erro ao carregar filmes")
                        )
                    }
                })
                .disposed(by: MovieThunk.disposeBag)

        }
    }
}
