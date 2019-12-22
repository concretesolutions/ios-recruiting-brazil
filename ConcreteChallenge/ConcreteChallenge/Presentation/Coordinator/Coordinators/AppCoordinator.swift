//
//  AppCoordinator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// The coordinator of the root view controller
class AppCoordinator: Coordinator {
    lazy var rootViewController: RootViewController = {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = UIColor.appLightPurple
        tabBarController.tabBar.tintColor = UIColor.appExtraLightRed
        tabBarController.tabBar.barStyle = .black
    
        return tabBarController
    }()
    
    private let popularAndFavoritesPresentationManager = MovieListPresentationManager(modes: [
        MovieListPresentationMode(
            cellType: MinimizedMovieCollectionCell.self,
            iconImage: UIImage(named: "grid"),
            numberOfColumns: 3, heightFactor: 1.7
        ),
        MovieListPresentationMode(
            cellType: MaximizedMovieCollectionCell.self,
            iconImage: UIImage(named: "expanded"),
            numberOfColumns: 1, heightFactor: 1.3
        )
    ])
    
    private let searchPresentationManager = MovieListPresentationManager(modes: [
        MovieListPresentationMode(
            cellType: InformativeMovieCollectionViewCell.self,
            iconImage: nil,
            numberOfColumns: 1, heightFactor: 0.4
        ),
    ])
    
    private lazy var popularMoviesCoordinator: ListOfMoviesCoordinator = {
        let popularMoviesCoordinator = ListOfMoviesCoordinator(
            rootViewController: rootViewController,
            viewModelsFactory: self.viewModelsFactory,
            atributtes: ("Popular", .custom("Home", "home")),
            moviesListPresentationManager: popularAndFavoritesPresentationManager
        )
        
        popularMoviesCoordinator.userUnFavedMovieCompletion = { [weak self] movie in
            self?.favoriteMoviesCoordinator.movieRemovedInOtherScene(movie: movie)
        }
        
        popularMoviesCoordinator.userFavedMovieCompletion = { [weak self] movie in
            self?.favoriteMoviesCoordinator.movieWasAddedInOtherScene(movie: movie)
        }
        
        return popularMoviesCoordinator
    }()
    
    private lazy var favoriteMoviesCoordinator: ListOfMoviesCoordinator = {
        let favoriteMoviesCoordinator = FavoriteMoviesCoordinator(
            rootViewController: rootViewController,
            viewModelsFactory: FavoriteViewModelsFactory(),
            atributtes: ("Favorites", .system(.favorites)),
            moviesListPresentationManager: popularAndFavoritesPresentationManager
        )
        
        favoriteMoviesCoordinator.userUnFavedMovieCompletion = { [weak self] movie in
            self?.popularMoviesCoordinator.movieChangedInOtherScene(movie: movie)
        }
        
        return favoriteMoviesCoordinator
    }()
    
    private lazy var searchMoviesCoordinator: SearchMoviesCoordinator = {
        let searchMoviesCoordinator = SearchMoviesCoordinator(
            rootViewController: rootViewController,
            viewModelsFactory: self.viewModelsFactory
        )
        
//        searchMoviesCoordinator.userUnFavedMovieCompletion = { [weak self] movie in
//            self?.popularMoviesCoordinator.movieChangedInOtherScene(movie: movie)
//        }
        
        return searchMoviesCoordinator
    }()

    private lazy var firstTabCoordinator = GenericNavigationCoordinator(
        rootViewController: rootViewController,
        childCoordinator: popularMoviesCoordinator
    )
    
    private lazy var secondTabCoordinator = GenericNavigationCoordinator(
        rootViewController: rootViewController,
        childCoordinator: favoriteMoviesCoordinator
    )
    
    private lazy var thirdTabCoordinator = GenericNavigationCoordinator(
        rootViewController: rootViewController,
        childCoordinator: searchMoviesCoordinator
    )
    
    private let viewModelsFactory: ViewModelsFactory
    
    init(viewModelsFactory: ViewModelsFactory) {
        self.viewModelsFactory = viewModelsFactory
    }
    
    func start(previousController: UIViewController? = nil) {
        guard let window = UIApplication.shared.delegate?.window else {
            return
        }

        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        thirdTabCoordinator.start()
        secondTabCoordinator.start()
        firstTabCoordinator.start()
    }
}
