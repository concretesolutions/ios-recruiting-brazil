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
    
    func movieListViewModel(moviesRepository: MoviesRepository? = nil, emptyStateTitle: String? = nil) -> MoviesListViewModel {
        return DefaultMoviesListViewModel(
            moviesRepository: moviesRepository ?? DefaultMoviesRepository(moviesProvider: URLSessionJSONParserProvider<Page<Movie>>()), presentations: [
                Presentation(hasFavorite: false),
                Presentation(hasFavorite: true)
            ],
            emptyStateTitle: emptyStateTitle
        ) { (injectorData) -> MovieViewModel in
            switch injectorData {
            case .favorite(let movie):
                return self.movieViewModelWithFavoriteOptions(movie: movie)
            case .normal(let movie):
                return self.movieViewModel(movie: movie)
            }
        }
    }
    
    func searchMoviesViewModel() -> SeachMoviesViewModel {
        return DefaultSeachMoviesViewModel(moviesSearchRepository: DefaultSearchMoviesRepository(moviesProvider: URLSessionJSONParserProvider<Page<Movie>>())) { (movieRepositoryData) -> MoviesListViewModel in
            return self.movieListViewModel(moviesRepository: movieRepositoryData.repository, emptyStateTitle: movieRepositoryData.emptyState)
        }
    }
}

