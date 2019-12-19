//
//  MoviesListViewModel.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import GenericNetwork

protocol MoviesListViewModel {
    
}

class DefaultMoviesListViewModel<MoviesProviderType: ParserProvider>: MoviesListViewModel where MoviesProviderType.ParsableType == Movie {
    let moviesProvider: MoviesProviderType
    
    init(moviesProvider: MoviesProviderType) {
        self.moviesProvider = moviesProvider
    }
}
