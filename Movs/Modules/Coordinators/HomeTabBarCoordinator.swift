//
//  HomeTabBarCoordinator.swift
//  Movs
//
//  Created by Gabriel D'Luca on 06/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class HomeTabBarCoordinator: Coordinator {
    
    // MARK: - Typealiases
    
    typealias Presenter = UINavigationController
    typealias Controller = HomeTabBarViewController
    
    // MARK: - Properties
    
    internal let dependencies: Dependencies
    internal let coordinatedViewController: Controller
    internal let presenter: Presenter
    
    // MARK: - Child coordinators
    
    private var favoriteMoviesCoordinator: FavoriteMoviesCoordinator!
    private var popularMoviesCoordinator: PopularMoviesCoordinator!
    
    // MARK: - Initializers and Deinitializers
    
    init(parent: AppCoordinator) {
        self.presenter = parent.coordinatedViewController
        self.dependencies = parent.dependencies

        self.coordinatedViewController = HomeTabBarViewController()
        self.popularMoviesCoordinator = PopularMoviesCoordinator(parent: self)
        self.favoriteMoviesCoordinator = FavoriteMoviesCoordinator(parent: self)
    }
        
    // MARK: - Coordinator
    
    func start() {
        self.coordinatedViewController.viewControllers = [self.popularMoviesCoordinator.coordinatedViewController, self.favoriteMoviesCoordinator.coordinatedViewController]
        self.presenter.pushViewController(self.coordinatedViewController, animated: true)
    }
    
    func finish() {
        self.popularMoviesCoordinator.finish()
        self.favoriteMoviesCoordinator.finish()
        
        self.popularMoviesCoordinator = nil
        self.favoriteMoviesCoordinator = nil
    }
}
