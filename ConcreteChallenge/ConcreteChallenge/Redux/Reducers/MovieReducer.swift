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
    var page: Int = 0
    var errorMessage: String = ""
    var movies: [Movie] = []
    var currentMovieDetails: MovieDetails?
    
    static func == (lhs: MovieState, rhs: MovieState) -> Bool {
        return lhs.movies == rhs.movies
    }
}

func movieReducer(action: MovieActions, state: MovieState?, rootState: RootState) -> MovieState {
    var state = state ?? MovieState()

    switch action {
    case .set(let movies):
        state.movies = movies
    case .addMovies(page: let page, movies: let movies):
        state.loading = false
        state.errorMessage = ""
        state.page = page
        
        let movies: [Movie] = movies.map { movie in
            movie.genres = rootState.genre
                .genres.filter({ movie.genreIds.contains($0.id) })
                .map({ $0.name })
            
            movie.favorited = rootState.favorites
                .favorites.contains(where: { $0.id == movie.id })
            
            return movie
        }
        
        state.movies.append(contentsOf: movies)
    case .requestStated:
        state.loading = true
        state.errorMessage = ""
    case .requestError(message: let message):
        state.loading = false
        state.errorMessage = message
    case .movieDetails(let details):
        state.currentMovieDetails = details
    }
    return state
}
