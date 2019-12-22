//
//  PopularMoviesCoordinator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

class PopularMoviesCoordinator: Coordinator {
    var rootViewController: RootViewController
    
    private lazy var popularMoviesViewController: PopularMoviesViewController = {
        let viewModel = self.viewModelsFactory.movieListViewModel()
        viewModel.navigator = self
        
        let popularMoviesViewController = PopularMoviesViewController(viewModel: viewModel)
        return popularMoviesViewController
    }()
    private var movieDetailCoordinator: MovieDetailCoordinator?
    private var viewModelsFactory: ViewModelsFactory
    
    init(rootViewController: RootViewController, viewModelsFactory: ViewModelsFactory) {
        self.rootViewController = rootViewController
        self.viewModelsFactory = viewModelsFactory
    }
    
    func start(previousController: UIViewController? = nil) {
        rootViewController.add(viewController: popularMoviesViewController)
        
        popularMoviesViewController.title = "Popular"
        rootViewController.tabBarItem = UITabBarItem.init(title: "Home", image: UIImage(named: "home"), tag: 0)
        rootViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
    }
}

extension PopularMoviesCoordinator: MoviesListViewModelNavigator {
    func movieWasSelected(movie: Movie) {
        movieDetailCoordinator = MovieDetailCoordinator(rootViewController: rootViewController, movie: movie)
        movieDetailCoordinator?.start(previousController: popularMoviesViewController)
    }
}
