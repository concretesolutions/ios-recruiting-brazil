//
//  GenreAction.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import ReSwift

enum GenreActions: Action {
    case set([Genre])
    case requestStated
    case requestError(message: String)
}
