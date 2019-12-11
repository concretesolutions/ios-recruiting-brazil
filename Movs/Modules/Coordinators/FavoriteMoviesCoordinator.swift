//
//  FavoriteMoviesCoordinator.swift
//  Movs
//
//  Created by Gabriel D'Luca on 06/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class FavoriteMoviesCoordinator: Coordinator {

    // MARK: - Typealiases
    
    typealias Presenter = UITabBarController
    typealias Controller = FavoriteMoviesViewController
    
    // MARK: - Properties
    
    internal let dependencies: Dependencies
    internal let coordinatedViewController: Controller
    internal let presenter: Presenter
    
    // MARK: - Initializers and Deinitializers
    
    init(parent: HomeTabBarCoordinator) {
        self.presenter = parent.coordinatedViewController
        self.dependencies = parent.dependencies
        
        let viewModel = FavoriteMoviesControllerViewModel(dependencies: self.dependencies)
        self.coordinatedViewController = FavoriteMoviesViewController(viewModel: viewModel)
        self.coordinatedViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
    }
    
    // MARK: - Coordinator
    
    func start() { }
    
    func finish() { }
}
