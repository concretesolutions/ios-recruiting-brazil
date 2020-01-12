//
//  MoviesCoordinator.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 18/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

struct MoviesCoordinator: Coordinator {
    var presenter: UINavigationController
    var rootViewController: MoviesViewController

    init(presenter: UINavigationController = UINavigationController(),
         moviesViewController: MoviesViewController = MoviesViewController()) {
        self.presenter = presenter
        self.rootViewController = moviesViewController
    }

    func start() {
        // MARK: NavigationController style
        presenter.navigationBar.prefersLargeTitles = true

        // MARK: Bindings
        rootViewController.viewModel.showMovieDetail = showMovieDetail

        presenter.pushViewController(rootViewController, animated: false)
    }

    func showMovieDetail(movie: Movie) {
        let movieDetailViewModel = MovieDetailViewModel(movie: movie)
        let movieDetailViewController = MovieDetailViewController(viewModel: movieDetailViewModel)

        let movieDetailCoordinator = MovieDetailCoordinator(presenter: presenter,
                                                            movieDetailViewController: movieDetailViewController)
        movieDetailCoordinator.start()
    }
}
