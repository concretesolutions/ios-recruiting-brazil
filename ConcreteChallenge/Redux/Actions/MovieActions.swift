//
//  MovieAction.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import ReSwift

enum MovieActions: Action, Equatable {
    case set([Movie])
    case addMovies([Movie], page: Int, total: Int, filters: MovieFilters)
    case updateMovieDetails(MovieDetails)
    case movieDetails(MovieDetails)
    case requestStated(isSearching: Bool, isPaginating: Bool)
    case requestError(message: String)
}
