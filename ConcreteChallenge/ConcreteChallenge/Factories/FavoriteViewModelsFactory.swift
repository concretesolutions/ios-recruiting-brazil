//
//  FavoriteViewModelsFactory.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class FavoriteViewModelsFactory: DefaultViewModelFactory {
    override func movieListViewModel() -> MoviesListViewModel {
        return DefaultMoviesListViewModel(moviesRepository: FavoriteMoviesRepository()) { (injectorData) -> MovieViewModel in
            switch injectorData {
            case .cards(let movie):
                return self.movieViewModelWithFavoriteOptions(movie: movie)
            case .grid(let movie):
                return self.movieViewModel(movie: movie)
            }
        }
    }
}
