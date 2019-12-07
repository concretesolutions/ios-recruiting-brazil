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
    
    private let apiManager: MoviesAPIManager
    internal let coordinatedViewController: Controller
    internal let presenter: Presenter
    
    // MARK: - Child coordinators
    
    private var favoriteMoviesCoordinator: FavoriteMoviesCoordinator
    private var popularMoviesCoordinator: PopularMoviesCoordinator
    
    // MARK: - Initializers and Deinitializers
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.apiManager = MoviesAPIManager()

        self.coordinatedViewController = HomeTabBarViewController()
        self.popularMoviesCoordinator = PopularMoviesCoordinator(presenter: self.coordinatedViewController, apiManager: self.apiManager)
        self.favoriteMoviesCoordinator = FavoriteMoviesCoordinator(presenter: self.coordinatedViewController, apiManager: self.apiManager)
    }
        
    // MARK: - Coordination
    
    func start() {
        self.coordinatedViewController.viewControllers = [self.popularMoviesCoordinator.coordinatedViewController, self.favoriteMoviesCoordinator.coordinatedViewController]
        self.presenter.pushViewController(self.coordinatedViewController, animated: true)
    }
}
