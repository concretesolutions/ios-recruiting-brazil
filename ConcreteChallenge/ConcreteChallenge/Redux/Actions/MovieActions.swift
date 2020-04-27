//
//  MovieAction.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import ReSwift

enum MovieActions: Action {
    case set([Movie])
    case addMovies(page: Int, movies: [Movie])
    case movieDetails(MovieDetails)
    case requestStated
    case requestError(message: String)
}
