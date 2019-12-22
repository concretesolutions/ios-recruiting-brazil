//
//  FavoriteMoviesCoordinator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class FavoriteMoviesCoordinator: ListOfMoviesCoordinator {
    override var movieDetailCoordinator: MovieDetailCoordinator? {
        didSet {
            movieDetailCoordinator?.userUnFavedMovieCompletion = { [weak self] movie in
                self?.movieDetailCoordinator?.stop(completion: {
                    self?.moviesListViewController.viewModel.deleteMovie(movie)
                    self?.userUnFavedMovieCompletion?(movie)
                })
            }
        }
    }
    
    override func movieWasUnfaved(movie: Movie) {
        self.moviesListViewController.viewModel.deleteMovie(movie)
        self.userUnFavedMovieCompletion?(movie)
    }
}
