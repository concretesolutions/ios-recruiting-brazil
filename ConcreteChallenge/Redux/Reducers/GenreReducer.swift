//
//  GenreReducer.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import ReSwift
import ReSwiftThunk

struct GenreState: StateType, Equatable {
    var loading: Bool = false
    var errorMessage: String = ""
    var genres: [Genre] = []

    static func == (lhs: GenreState, rhs: GenreState) -> Bool {
        return lhs.genres == rhs.genres
    }
}

func genreReducer(action: GenreActions, state: GenreState?, rootState: RootState?) -> GenreState {
    var state = state ?? GenreState()

    switch action {
    case .set(let genres):
        state.loading = false
        state.errorMessage = ""
        state.genres.append(contentsOf: genres)
    case .requestStated:
        state.errorMessage = ""
        state.loading = true
    case .requestError(message: let message):
        state.loading = false
        state.errorMessage = message
    }
    return state
}
