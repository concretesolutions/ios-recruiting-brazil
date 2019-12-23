//
//  MovieViewModelWithSimilarOptions.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class DefaultMovieViewModelWithSimilarOptions: MovieViewModelDecorator, MovieViewModelWithSimilarOptions {
    private var similarMoviesRepository: SimilarMoviesRepository
    
    var moviesListViewModel: MoviesListViewModel
    
    init(similarMoviesRepository: SimilarMoviesRepository,
         _ decorated: MovieViewModelWithData,
         movieViewModelInjector: Injector<MoviesListViewModel, MoviesRepository>) {
        
        self.similarMoviesRepository = similarMoviesRepository
        self.moviesListViewModel = movieViewModelInjector(similarMoviesRepository)
        
        super.init(decorated)
        
        self.similarMoviesRepository.similarMovieIdProvider = { [weak self] in
            return self?.movie.id
        }
    }
}
