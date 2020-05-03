//
//  Persistance.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//
import CoreData
import RxSwift
import ReSwift
import ReSwiftThunk

class Persistance {
    static let disposeBag = DisposeBag()

    static func loadPesistent(then nextActions: [Action]) -> Thunk<RootState> {
        return Thunk<RootState> { dispatch, getState in
            if getState() == nil { return }

            dispatch(FavoriteThunk.refreshFromPersistance())

            nextActions.forEach(dispatch)
        }
    }
}
