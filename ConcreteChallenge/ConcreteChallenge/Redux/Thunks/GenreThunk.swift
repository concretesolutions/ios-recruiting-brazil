//
//  GenreThunk.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import RxSwift
import ReSwift
import ReSwiftThunk


class GenreThunk {
    static let disposeBag = DisposeBag()
    
    static func fetchGenres() -> Thunk<RootState> {
        
        return Thunk<RootState> { dispatch, getState in
            guard let state = getState() else { return }
            
            if state.genre.loading || !state.infra.isConnected {
                return
            }
            
            DispatchQueue.main.async {
                dispatch(GenreActions.requestStated)
            }
            
            
            Genre.getAll()
                .subscribe(
                    onSuccess: { genres in
                        DispatchQueue.main.async {
                            dispatch(GenreActions.set(genres))
                        }
                    },
                    onError: { error in
                        DispatchQueue.main.async {
                            dispatch(
                                GenreActions.requestError(message: "Erro ao carregar gêneros")
                            )
                        }
                    }
                )
                .disposed(by: GenreThunk.disposeBag)
        }
    }
}
