//
//  DefaultViewModelFactory.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import GenericNetwork

class DefaultViewModelFactory: ViewModelsFactory {
    func movieViewModel(movie: Movie) -> MovieViewModel {
        return DefaultMovieViewModel(
            movie: movie,
            imageRepository: DefaultMovieImageRepository(imagesProvider: URLSessionFileProvider()),
            genresRepository: DefaultGenresRepository(genresProvider: URLSessionJSONParserProvider())
        )
    }
    
    func movieViewModelWithFavoriteOptions(movie: Movie) -> MovieViewModelWithFavoriteOptions {
        return DefaultMovieViewModelWithFavoriteOptions(
            favoriteHandlerRepository: DefaultFavoriteMovieHandlerRepository(),
            decorated: movieViewModel(movie: movie) as! DefaultMovieViewModel
        )
    }
    
    func movieListViewModel() -> MoviesListViewModel {
        return DefaultMoviesListViewModel(
            moviesRepository: DefaultMoviesRepository(moviesProvider: URLSessionJSONParserProvider<Page<Movie>>()),
            movieViewModelInjector: movieViewModelWithFavoriteOptions
        )
    }
}

