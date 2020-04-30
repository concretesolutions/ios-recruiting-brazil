//
//  MovieReducer.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import ReSwift
import ReSwiftThunk

struct MovieState: StateType, Equatable {
    var loading: Bool = false
    var isSearching: Bool = false
    var isPaginating: Bool = false
    var page: Int = 0
    var totalPages: Int = 2
    var filters: MovieFilters = MovieFilters()
    var errorMessage: String = ""
    var movies: [Movie] = []
    var currentMovieDetails: MovieDetails?

    static func == (lhs: MovieState, rhs: MovieState) -> Bool {
        return lhs.movies == rhs.movies
            && lhs.page == rhs.page
            && lhs.totalPages == rhs.totalPages
            && lhs.filters == rhs.filters
            && lhs.errorMessage == rhs.errorMessage
            && lhs.loading == rhs.loading
            && lhs.currentMovieDetails == rhs.currentMovieDetails
    }
}

func movieReducer(action: MovieActions, state: MovieState?, rootState: RootState) -> MovieState {
    var state = state ?? MovieState()

    switch action {
    case .set(let movies):
        state.movies = movies
    case .addMovies(let movies, page: let page, total: let totalPages, filters: let filters):
        state.loading = false
        state.isSearching = false
        state.isPaginating = false
        state.errorMessage = ""
        state.page = page
        state.totalPages = totalPages
        state.filters = filters

        let movies: [Movie] = movies.map { movie in
            movie.genres = rootState.genre
                .genres.filter({ movie.genreIds.contains($0.id) })
                .map({ $0.name })

            movie.favorited = rootState.favorites
                .favorites.contains(where: { $0.id == movie.id })

            return movie
        }
        if page == 1 {
            state.movies = movies
        } else {
            state.movies.append(contentsOf: movies)
        }
    case .requestStated(isSearching: let isSearching, isPaginating: let isPaginating):
        state.loading = true
        state.isSearching = isSearching
        state.isPaginating = isPaginating
        state.errorMessage = ""
    case .requestError(message: let message):
        state.loading = false
        state.isSearching = false
        state.isPaginating = false
        state.errorMessage = message
    case .updateMovieDetails(let details):
        state.currentMovieDetails = details
    case .movieDetails(let details):
        details.favorited = rootState.favorites
            .favorites.contains(where: { $0.id == details.id })
        state.currentMovieDetails = details
    }
    return state
}
