//
//  MovieViewModelWithSimilarOptions.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// Its a type of movie viewmodel that has similar movies options. That provides data for movie views that contains similar movies section(only the movie detail view)
protocol MovieViewModelWithSimilarOptions: MovieViewModel {
    var moviesListViewModel: MoviesListViewModel { get }
}

extension MovieViewModel {
    var withSimilarOptions: MovieViewModelWithSimilarOptions? {
        return MovieViewModelDecorator.searchDecorator(ofType: MovieViewModelWithSimilarOptions.self, in: self)
    }
}
