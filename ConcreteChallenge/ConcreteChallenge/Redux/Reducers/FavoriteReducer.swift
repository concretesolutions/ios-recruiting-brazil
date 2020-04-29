//
//  FavoriteReducer.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import ReSwift
import ReSwiftThunk
import CoreData

struct FavoriteState: StateType, Equatable {
    var favorites: [Favorite] = []
    var searchResults: [Favorite] = []
    var latestError: String = ""
    
    var filters: FavoriteFilters = FavoriteFilters()
    
    static func == (lhs: FavoriteState, rhs: FavoriteState) -> Bool {
        return lhs.favorites == rhs.favorites
            && lhs.latestError == rhs.latestError
            && lhs.filters == rhs.filters
    }
}

func favoriteReducer(action: FavoriteActions, state: FavoriteState?, rootState: RootState?) -> FavoriteState {
    var state = state ?? FavoriteState()
    
    switch action {
    case .set(let favorites):
        state.favorites = favorites
    case .setError(let error):
        state.latestError = error.localizedDescription
    case .searchResults(let results, with: let filters):
        state.searchResults = results
        state.filters = filters
    case .setFilters(let filters):
        state.filters = filters
    }
    return state
        
}
