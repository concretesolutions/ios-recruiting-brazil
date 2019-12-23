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
        let viewModel = viewModelsFactory.movieViewModelWithSimilarAndFavoriteOptions(movie: movie)
        viewModel.withFavoriteOptions?.favoritesNavigator = self
        viewModel.withSimilarOptions?.moviesListViewModel.navigator = self
        viewModel.navigator = self
        
        let movieDetailViewController = MovieDetailViewController(viewModel: viewModel)
        return movieDetailViewController
    }()
    
    var movieDetailCoordinator: MovieDetailCoordinator? {
        didSet {
            movieDetailCoordinator?.userFavedMovieCompletion = { [weak self] movie in
                self?.movieDetailViewController.viewModel.withSimilarOptions?.moviesListViewModel.reloadMovie(movie)
                self?.userFavedMovieCompletion?(movie)
            }
            movieDetailCoordinator?.userUnFavedMovieCompletion = { [weak self] movie in
                self?.movieDetailViewController.viewModel.withSimilarOptions?.moviesListViewModel.reloadMovie(movie)
                self?.userUnFavedMovieCompletion?(movie)
            }
        }
    }
    
    private let viewModelsFactory: ViewModelsFactory
    
    init(rootViewController: RootViewController, movie: Movie, viewModelsFactory: ViewModelsFactory) {
        self.movie = movie
        self.rootViewController = rootViewController
        self.viewModelsFactory = viewModelsFactory
    }
    
    func start(previousController: UIViewController?) {
        movieDetailViewController.modalPresentationStyle = .overFullScreen
        previousController?.present(movieDetailViewController, animated: true, completion: nil)
    }
    
    func stop(completion: (() -> Void)?) {
        movieDetailViewController.dismiss(animated: true, completion: completion)
    }
}

extension MovieDetailCoordinator: MovieViewModelWithFavoriteOptionsNavigator, MovieViewModelNavigator {
    func closeWasTapped() {
        movieDetailViewController.dismiss(animated: true, completion: nil)
    }
    
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

extension MovieDetailCoordinator: MoviesListViewModelNavigator {
    func movieWasSelected(movie: Movie) {
        movieDetailCoordinator = MovieDetailCoordinator(
            rootViewController: rootViewController,
            movie: movie,
            viewModelsFactory: self.viewModelsFactory
        )
        movieDetailCoordinator?.start(previousController: movieDetailViewController)
    }
    
    func movieWasFaved(movie: Movie) {
        DispatchQueue.main.async {
            self.userFavedMovieCompletion?(movie)
        }
    }
    
    func movieWasUnfaved(movie: Movie) {
        DispatchQueue.main.async {
            self.userUnFavedMovieCompletion?(movie)
        }
    }
}
