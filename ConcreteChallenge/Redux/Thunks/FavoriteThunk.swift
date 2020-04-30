//
//  FavoriteThunk.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 24/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import RxSwift
import ReSwift
import ReSwiftThunk

class FavoriteThunk {
    private static let entityName = "FavoriteData"

    static func refreshFromPersistance() -> Thunk<RootState> {
        return Thunk<RootState> { dispatch, _ in

            do {
                let favorites: [Favorite] = try PersistanceManager.get(from: FavoriteThunk.entityName) ?? []
                dispatch(FavoriteActions.set(favorites))
                dispatch(MovieThunk.dependencyUpdated())
            } catch let error as NSError {
                dispatch(FavoriteActions.setError(error))
            }
        }
    }

    static func remove(id: Int) -> Thunk<RootState> {
        return Thunk<RootState> { dispatch, getState in
            guard let _ = getState() else { return }
            do {
                try PersistanceManager.delete(id, from: FavoriteThunk.entityName)
                dispatch(FavoriteThunk.refreshFromPersistance())
            } catch let error as NSError {
                dispatch(FavoriteActions.setError(error))
            }
        }
    }

    static func clear() -> Thunk<RootState> {
        return Thunk<RootState> { dispatch, _ in

            do {
                try PersistanceManager.clear(from: FavoriteThunk.entityName)
                dispatch(FavoriteThunk.refreshFromPersistance())
            } catch let error as NSError {
                dispatch(FavoriteActions.setError(error))
            }
        }
    }

    static func insert(_ favorite: Favorite) -> Thunk<RootState> {

        return Thunk<RootState> { dispatch, _ in
            do {
                try PersistanceManager.persist(favorite)
                dispatch(FavoriteThunk.refreshFromPersistance())
            } catch let error as NSError {
                dispatch(FavoriteActions.setError(error))
            }
        }
    }

    static func search(filteringBy filters: FavoriteFilters) -> Thunk<RootState> {

        return Thunk<RootState> { dispatch, _ in

            var predicates: [NSPredicate] = []

            if let keyword = filters.keyword {
                predicates.append(NSPredicate(format: "title CONTAINS[c] %@ OR overview CONTAINS[c] %@", keyword, keyword))
            }

            if filters.year != nil {
                predicates.append(NSPredicate(format: "releaseDate BEGINSWITH %@", "\(filters.year!)"))
            }

            do {
                var favorites: [Favorite] = try PersistanceManager.get(from: FavoriteThunk.entityName, predicates: predicates) ?? []

                if let genre = filters.genre {
                    favorites = favorites.filter({ $0.genreIds.contains(genre.id) })
                }

                dispatch(FavoriteActions.searchResults(favorites, with: filters))
            } catch let error as NSError {
                dispatch(FavoriteActions.setError(error))
            }
       }
   }
}

