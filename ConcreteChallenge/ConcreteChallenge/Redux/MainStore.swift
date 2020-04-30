//
//  MainState.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import ReSwift
import ReSwiftThunk

struct RootState: StateType, Equatable {
    var genre: GenreState = GenreState()
    var movie: MovieState = MovieState()
    var favorites: FavoriteState = FavoriteState()
    var infra: InfraState = InfraState()
}

func rootReducer(action: Action, state: RootState?) -> RootState {
    var state = state ?? RootState()

    switch action {
    case is GenreActions:
        state.genre = genreReducer(
            action: action as! GenreActions,
            state: state.genre,
            rootState: state
        )
    case is MovieActions:
        state.movie = movieReducer(
            action: action as! MovieActions,
            state: state.movie,
            rootState: state
        )
    case is FavoriteActions:
        state.favorites = favoriteReducer(
            action: action as! FavoriteActions,
            state: state.favorites,
            rootState: state
        )
    case is InfraActions:
        state.infra = infraReducer(
            action: action as! InfraActions,
            state: state.infra,
            rootState: state
        )
    default:
        break
    }
    return state

}

let thunksMiddleware: Middleware<RootState> = createThunkMiddleware()

let mainStore = Store(
    reducer: rootReducer,
    state: RootState(),
    middleware: [thunksMiddleware]
)
