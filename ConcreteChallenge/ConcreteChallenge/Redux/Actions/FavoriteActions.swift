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
    case insert(Favorite)
    case remove(id: Int)
    case clear
}
