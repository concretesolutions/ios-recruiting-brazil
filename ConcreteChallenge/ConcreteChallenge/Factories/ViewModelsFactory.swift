//
//  ViewModelsFactory.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol ViewModelsFactory: AnyObject {
    func movieViewModel(movie: Movie) -> MovieViewModel
    func movieListViewModel(moviesRepository: MoviesRepository?, emptyStateTitle: String?) -> MoviesListViewModel
    func movieViewModelWithFavoriteOptions(movie: Movie) -> MovieViewModelWithFavoriteOptions
    func searchMoviesViewModel() -> SeachMoviesViewModel
}
