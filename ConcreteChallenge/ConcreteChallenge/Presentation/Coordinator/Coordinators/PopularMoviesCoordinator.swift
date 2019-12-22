//
//  PopularMoviesCoordinator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

enum TabbarAttributtes {
    case system(UITabBarItem.SystemItem)
    case custom(String, String)
}
typealias PopularCoordinatorAtributtes = (navigationTitle: String, tabbarAttributtes: TabbarAttributtes)

extension UITabBarItem {
    convenience init(tabbarAttributtes: TabbarAttributtes) {
        switch tabbarAttributtes {
        case .custom(let title, let imageName):
            self.init(
                title: title,
                image: UIImage(named: imageName),
                tag: 0
            )
        case .system(let systemItem):
            self.init(tabBarSystemItem: systemItem, tag: 0)
        }
    }
}

typealias UserFavedMovieEvent = (_ movie: Movie) -> Void

class PopularMoviesCoordinator: Coordinator, MoviesListViewModelNavigator {
    var rootViewController: RootViewController
    
    var userFavedMovieCompletion: UserFavedMovieEvent?
    var userUnFavedMovieCompletion: UserFavedMovieEvent?
    
    lazy var popularMoviesViewController: PopularMoviesViewController = {
        let viewModel = self.viewModelsFactory.movieListViewModel()
        viewModel.navigator = self
        
        let popularMoviesViewController = PopularMoviesViewController(viewModel: viewModel)
        return popularMoviesViewController
    }()
    
    var movieDetailCoordinator: MovieDetailCoordinator? {
        didSet {
            movieDetailCoordinator?.userFavedMovieCompletion = { [weak self] movie in
                self?.popularMoviesViewController.viewModel.reloadMovie(movie)
                self?.userFavedMovieCompletion?(movie)
            }
            
            movieDetailCoordinator?.userUnFavedMovieCompletion = { [weak self] movie in
                self?.popularMoviesViewController.viewModel.reloadMovie(movie)
                self?.userUnFavedMovieCompletion?(movie)
            }
        }
    }
    private var viewModelsFactory: ViewModelsFactory
    private let atributtes: PopularCoordinatorAtributtes
    
    init(rootViewController: RootViewController, viewModelsFactory: ViewModelsFactory, atributtes: PopularCoordinatorAtributtes) {
        self.rootViewController = rootViewController
        self.viewModelsFactory = viewModelsFactory
        self.atributtes = atributtes
    }
    
    func start(previousController: UIViewController? = nil) {
        rootViewController.add(viewController: popularMoviesViewController)
        
        popularMoviesViewController.title = atributtes.navigationTitle
        
        rootViewController.tabBarItem = UITabBarItem(tabbarAttributtes: atributtes.tabbarAttributtes)
        rootViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
    }
    
    func movieChangedInOtherScene(movie: Movie) {
        self.popularMoviesViewController.viewModel.reloadMovie(movie)
    }
    
    func movieWasAddedInOtherScene(movie: Movie) {
        self.popularMoviesViewController.viewModel.insertMovie(movie)
    }
    
    func movieRemovedInOtherScene(movie: Movie) {
        self.popularMoviesViewController.viewModel.deleteMovie(movie)
    }
    
    func movieWasSelected(movie: Movie) {
        movieDetailCoordinator = MovieDetailCoordinator(
            rootViewController: rootViewController,
            movie: movie,
            viewModelsFactory: self.viewModelsFactory
        )
        movieDetailCoordinator?.start(previousController: popularMoviesViewController)
    }
    
    func movieWasFaved(movie: Movie) {
        self.userFavedMovieCompletion?(movie)
    }

    func movieWasUnfaved(movie: Movie) {
        self.userUnFavedMovieCompletion?(movie)
    }
}

class FavoriteMoviesCoordinator: PopularMoviesCoordinator {
    override var movieDetailCoordinator: MovieDetailCoordinator? {
        didSet {
            movieDetailCoordinator?.userUnFavedMovieCompletion = { [weak self] movie in
                self?.movieDetailCoordinator?.stop(completion: {
                    self?.popularMoviesViewController.viewModel.deleteMovie(movie)
                    self?.userUnFavedMovieCompletion?(movie)
                })
            }
        }
    }
    
    override func movieWasUnfaved(movie: Movie) {
        self.popularMoviesViewController.viewModel.deleteMovie(movie)
        self.userUnFavedMovieCompletion?(movie)
    }
}
