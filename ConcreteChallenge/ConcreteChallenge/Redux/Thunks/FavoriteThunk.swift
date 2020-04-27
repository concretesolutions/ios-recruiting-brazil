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
    
    static func remove(id: Int) -> Thunk<RootState> {

        return Thunk<RootState> { dispatch, getState in
            guard let _ = getState() else { return }
            dispatch(FavoriteActions.remove(id: id))
            dispatch(MovieThunk.dependencyUpdated())
        }
    }
    
    static func clear() -> Thunk<RootState> {
        return Thunk<RootState> { dispatch, getState in
            guard let _ = getState() else { return }
            dispatch(FavoriteActions.clear)
            dispatch(MovieThunk.dependencyUpdated())
        }
    }
    
    static func insert(_ favorite: Favorite) -> Thunk<RootState> {
        
        return Thunk<RootState> { dispatch, getState in
            guard let _ = getState() else { return }
            
            dispatch(FavoriteActions.insert(favorite))
            dispatch(MovieThunk.dependencyUpdated())
        }
    }
}
    
