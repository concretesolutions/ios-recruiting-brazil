//
//  DefaultViewModelFactory.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import GenericNetwork

struct DefaultViewModelFactory: ViewModelsFactory {
    func movieViewModel(movie: Movie) -> MovieViewModel {
        return DefaultMovieViewModel(
            movie: movie,
            imageRepository: DefaultMovieImageRepository(imagesProvider: URLSessionFileProvider()),
            genresRepository: DefaultGenresRepository(genresProvider: URLSessionJSONParserProvider())
        )
    }
    
    func movieListViewModel() -> MoviesListViewModel {
        return DefaultMoviesListViewModel(
            moviesRepository: DefaultMoviesRepository(moviesProvider: URLSessionJSONParserProvider<Page<Movie>>()),
            movieViewModelInjector: movieViewModel
        )
    }
}

