//
//  FavoritesCoordinator.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 12/01/20.
//  Copyright © 2020 Marcos Santos. All rights reserved.
//

import UIKit

struct FavoritesCoordinator: Coordinator {
    var presenter: UINavigationController
    var rootViewController: FavoritesViewController

    init(presenter: UINavigationController = UINavigationController(),
         favoritesViewController: FavoritesViewController = FavoritesViewController()) {
        self.presenter = presenter
        self.rootViewController = favoritesViewController
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
