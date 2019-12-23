//
//  MovieViewModelWithSimilarOptions.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol MovieViewModelWithSimilarOptions: MovieViewModel {
    var moviesListViewModel: MoviesListViewModel { get }
}

extension MovieViewModel {
    var withSimilarOptions: MovieViewModelWithSimilarOptions? {
        return MovieViewModelDecorator.searchDecorator(ofType: MovieViewModelWithSimilarOptions.self, in: self)
    }
}

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
