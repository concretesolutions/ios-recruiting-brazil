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
    
    private lazy var popularMoviesCoordinator: PopularMoviesCoordinator = {
        let popularMoviesCoordinator = PopularMoviesCoordinator(
            rootViewController: rootViewController,
            viewModelsFactory: self.viewModelsFactory,
            atributtes: ("Popular", .custom("Home", "home"))
        )
        
        popularMoviesCoordinator.userUnFavedMovieCompletion = { [weak self] movie in
            self?.favoriteMoviesCoordinator.movieRemovedInOtherScene(movie: movie)
        }
        
        popularMoviesCoordinator.userFavedMovieCompletion = { [weak self] movie in
            self?.favoriteMoviesCoordinator.movieWasAddedInOtherScene(movie: movie)
        }
        
        return popularMoviesCoordinator
    }()
    
    private lazy var favoriteMoviesCoordinator: PopularMoviesCoordinator = {
        let favoriteMoviesCoordinator = FavoriteMoviesCoordinator(
            rootViewController: rootViewController,
            viewModelsFactory: FavoriteViewModelsFactory(),
            atributtes: ("Favorites", .system(.favorites))
        )
        
        favoriteMoviesCoordinator.userUnFavedMovieCompletion = { [weak self] movie in
            self?.popularMoviesCoordinator.movieChangedInOtherScene(movie: movie)
        }
        
        return favoriteMoviesCoordinator
    }()

    private lazy var firstTabCoordinator = GenericNavigationCoordinator(
        rootViewController: rootViewController,
        childCoordinator: popularMoviesCoordinator
    )
    
    private lazy var secondTabCoordinator = GenericNavigationCoordinator(
        rootViewController: rootViewController,
        childCoordinator: favoriteMoviesCoordinator
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
        
        secondTabCoordinator.start()
        firstTabCoordinator.start()
    }
}
