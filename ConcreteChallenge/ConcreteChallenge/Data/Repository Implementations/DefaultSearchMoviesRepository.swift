
//
//  DefaultSearchMoviesRepository.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import GenericNetwork

class DefaultSearchMoviesRepository<MoviesProviderType: ParserProvider>: SearchMoviesRepository where MoviesProviderType.ParsableType == Page<Movie> {
   
    private let moviesProvider: MoviesProviderType
    
    init(moviesProvider: MoviesProviderType) {
        self.moviesProvider = moviesProvider
    }
    
    var searchQueryProvider: (() -> String?)?
       
    func getMovies(fromPage page: Int, completion: @escaping (Result<Page<Movie>, Error>) -> Void) {
        guard let query = searchQueryProvider?() else {
            return
        }
        moviesProvider.requestAndParse(route: TMDBMoviesRoute.searchMovies(query, page), completion: completion)
    }
}
