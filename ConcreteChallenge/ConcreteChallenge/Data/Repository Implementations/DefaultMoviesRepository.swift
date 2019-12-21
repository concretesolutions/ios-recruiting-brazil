//
//  DefaultMoviesRepository.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import GenericNetwork

class DefaultMoviesRepository<MoviesProviderType: ParserProvider>: MoviesRepository where MoviesProviderType.ParsableType == Page<Movie> {
    
    private let moviesProvider: MoviesProviderType
    
    init(moviesProvider: MoviesProviderType) {
        self.moviesProvider = moviesProvider
    }
    
    func getMovies(fromPage page: Int, completion: @escaping (Result<Page<Movie>, Error>) -> Void) {
        moviesProvider.requestAndParse(route: TMDBMoviesRoute.popular(page), completion: completion)
    }
}
