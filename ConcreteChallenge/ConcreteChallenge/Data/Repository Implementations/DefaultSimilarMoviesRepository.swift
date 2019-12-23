//
//  DefaultSimilarMoviesRepository.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import GenericNetwork

class DefaultSimilarMoviesRepository<MoviesProviderType: ParserProvider>: SimilarMoviesRepository where MoviesProviderType.ParsableType == Page<Movie> {
    var similarMovieIdProvider: (() -> Int?)?
    
    private let moviesProvider: MoviesProviderType
    
    init(moviesProvider: MoviesProviderType) {
        self.moviesProvider = moviesProvider
    }
    
    func getMovies(fromPage page: Int, completion: @escaping (Result<Page<Movie>, Error>) -> Void) {
        guard let similarMovieID = similarMovieIdProvider?() else {
            return
        }
        moviesProvider.requestAndParse(route: TMDBMoviesRoute.similar(page, similarMovieID), completion: completion)
    }
}
