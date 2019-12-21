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

    private lazy var viewModel: DefaultMoviesListViewModel = {
        let viewModel = DefaultMoviesListViewModel(
            moviesRepository: DefaultMoviesRepository(moviesProvider: URLSessionJSONParserProvider<Page<Movie>>()),
            imagesRepository: DefaultMovieImageRepository(imagesProvider: URLSessionFileProvider())
        )
        
        viewModel.navigator = self
        
        return viewModel
    }()
    
    private lazy var popularMoviesViewController = PopularMoviesViewController(viewModel: viewModel)
    private var movieDetailCoordinator: MovieDetailCoordinator?
    
    init(rootViewController: RootViewController) {
        self.rootViewController = rootViewController
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
