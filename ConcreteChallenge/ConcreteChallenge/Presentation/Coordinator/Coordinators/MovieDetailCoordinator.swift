//
//  MovieDetailCoordinator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

class MovieDetailCoordinator: StopableCoordinator {
    var rootViewController: RootViewController
    var userFavedMovieCompletion: UserFavedMovieEvent?
    var userUnFavedMovieCompletion: UserFavedMovieEvent?

    private let movie: Movie
    private lazy var movieDetailViewController: MovieDetailViewController = {
        let viewModel = viewModelsFactory.movieViewModelWithFavoriteOptions(movie: movie)
        viewModel.navigator = self
        let movieDetailViewController = MovieDetailViewController(viewModel: viewModel)
        return movieDetailViewController
    }()
    private let viewModelsFactory: ViewModelsFactory
    
    init(rootViewController: RootViewController, movie: Movie, viewModelsFactory: ViewModelsFactory) {
        self.movie = movie
        self.rootViewController = rootViewController
        self.viewModelsFactory = viewModelsFactory
    }
    
    func start(previousController: UIViewController?) {
        previousController?.present(movieDetailViewController, animated: true, completion: nil)
    }
    
    func stop(completion: (() -> Void)?) {
        movieDetailViewController.dismiss(animated: true, completion: completion)
    }
}

extension MovieDetailCoordinator: MovieViewModelWithFavoriteOptionsNavigator {
    func userUnFavedMovie(movie: Movie) {
        DispatchQueue.main.async {
            self.userUnFavedMovieCompletion?(movie)
        }
    }
    
    func userFavedMovie(movie: Movie) {
        DispatchQueue.main.async {
            self.userFavedMovieCompletion?(movie)
        }
    }
}
