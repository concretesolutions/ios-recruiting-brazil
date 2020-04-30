//
//  FavoriteActions.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import ReSwift

enum FavoriteActions: Action {
    case set([Favorite])
    case searchResults([Favorite], with: FavoriteFilters)
    case setError(NSError)
    case setFilters(FavoriteFilters)
}
