//
//  MovieDetailCoordinator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

class MovieDetailCoordinator: Coordinator {
    var rootViewController: RootViewController

    private let movie: Movie
    private lazy var movieDetailViewController = MovieDetailViewController(viewModel:
        viewModelsFactory.movieViewModelWithFavoriteOptions(movie: movie)
    )
    private let viewModelsFactory: ViewModelsFactory
    
    init(rootViewController: RootViewController, movie: Movie, viewModelsFactory: ViewModelsFactory) {
        self.movie = movie
        self.rootViewController = rootViewController
        self.viewModelsFactory = viewModelsFactory
    }
    
    func start(previousController: UIViewController?) {
        previousController?.present(movieDetailViewController, animated: true, completion: nil)
    }
}
