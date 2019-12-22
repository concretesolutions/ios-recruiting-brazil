//
//  SearchMoviesCoordinator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class SearchMoviesCoordinator: Coordinator, MoviesListViewModelNavigator {
    var rootViewController: RootViewController
    
    var userFavedMovieCompletion: UserFavedMovieEvent?
    var userUnFavedMovieCompletion: UserFavedMovieEvent?
    
    lazy var moviesListViewController: MovieSearchViewController = {
        let viewModel = self.viewModelsFactory.searchMoviesViewModel()
        viewModel.moviesViewModel.navigator = self
        
        let moviesListViewController = MovieSearchViewController(viewModel: viewModel)
        return moviesListViewController
    }()
    
    var movieDetailCoordinator: MovieDetailCoordinator? {
        didSet {
            movieDetailCoordinator?.userFavedMovieCompletion = { [weak self] movie in
                self?.moviesListViewController.viewModel.moviesViewModel.reloadMovie(movie)
                self?.userFavedMovieCompletion?(movie)
            }
            
            movieDetailCoordinator?.userUnFavedMovieCompletion = { [weak self] movie in
                self?.moviesListViewController.viewModel.moviesViewModel.reloadMovie(movie)
                self?.userUnFavedMovieCompletion?(movie)
            }
        }
    }
    private var viewModelsFactory: ViewModelsFactory
    
    init(rootViewController: RootViewController, viewModelsFactory: ViewModelsFactory) {
        self.rootViewController = rootViewController
        self.viewModelsFactory = viewModelsFactory
    }
    
    func start(previousController: UIViewController? = nil) {
        rootViewController.add(viewController: moviesListViewController)
        
        moviesListViewController.title = "Search"
        
        rootViewController.tabBarItem = UITabBarItem(tabbarAttributtes: TabbarAttributtes.custom("Search", "search"))
        rootViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
    }
    
    func movieChangedInOtherScene(movie: Movie) {
        self.moviesListViewController.viewModel.moviesViewModel.reloadMovie(movie)
    }
    
    func movieWasAddedInOtherScene(movie: Movie) {
        self.moviesListViewController.viewModel.moviesViewModel.insertMovie(movie)
    }
    
    func movieRemovedInOtherScene(movie: Movie) {
        self.moviesListViewController.viewModel.moviesViewModel.deleteMovie(movie)
    }
    
    func movieWasSelected(movie: Movie) {
        movieDetailCoordinator = MovieDetailCoordinator(
            rootViewController: rootViewController,
            movie: movie,
            viewModelsFactory: self.viewModelsFactory
        )
        movieDetailCoordinator?.start(previousController: moviesListViewController)
    }
    
    func movieWasFaved(movie: Movie) {
        self.userFavedMovieCompletion?(movie)
    }

    func movieWasUnfaved(movie: Movie) {
        self.userUnFavedMovieCompletion?(movie)
    }
}
