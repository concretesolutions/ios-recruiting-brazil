//
//  PopularMoviesCoordinator.swift
//  Movs
//
//  Created by Gabriel D'Luca on 06/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class PopularMoviesCoordinator: Coordinator {
    
    // MARK: - Typealiases
    
    typealias Presenter = UITabBarController
    typealias Controller = PopularMoviesViewController
    
    // MARK: - Properties

    private let apiManager: MoviesAPIManager
    internal let coordinatedViewController: Controller
    internal let presenter: Presenter
    
    // MARK: - Initializers and Deinitializers
    
    init(presenter: UITabBarController, apiManager: MoviesAPIManager) {
        self.presenter = presenter
        self.apiManager = apiManager
        
        let viewModel = PopularMoviesControllerViewModel(apiManager: apiManager)
        self.coordinatedViewController = PopularMoviesViewController(viewModel: viewModel)
        self.coordinatedViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        viewModel.coordinatorDelegate = self
    }
    
    // MARK: - Coordination
    
    func start() { }
}

extension PopularMoviesCoordinator: SelectionCoordinator {
    func didSelectItem(movie: Movie) {
        let coordinator = MovieDetailsCoordinator(presenter: self.coordinatedViewController, movie: movie, apiManager: self.apiManager)
        coordinator.start()
    }
}
