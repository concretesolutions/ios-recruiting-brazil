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
    var latestError: String = ""
    
    static func == (lhs: FavoriteState, rhs: FavoriteState) -> Bool {
        return lhs.favorites == rhs.favorites && lhs.latestError == rhs.latestError
    }
}

func favoriteReducer(action: FavoriteActions, state: FavoriteState?, rootState: RootState?) -> FavoriteState {
    var state = state ?? FavoriteState()
    
    let entityName = "FavoriteData"
    
    switch action {
        
    case .set(let favorites):
        state.favorites = favorites
    case .insert(let favorite):
        do {
            try PersistanceManager.persist(favorite)
            state.favorites.insert(favorite, at: 0)
        } catch let error as NSError {
            state.latestError = error.localizedDescription
        }
    case .remove(id: let id):
        do {
            try PersistanceManager.delete(id, from: entityName)
            state.favorites = state.favorites.filter({ $0.id != id })
        } catch let error as NSError {
            state.latestError = error.localizedDescription
        }
    case .clear:
        do {
            try PersistanceManager.clear(from: entityName)
            state.favorites = []
        } catch let error as NSError {
            state.latestError = error.localizedDescription
        }
    }
    return state
}
