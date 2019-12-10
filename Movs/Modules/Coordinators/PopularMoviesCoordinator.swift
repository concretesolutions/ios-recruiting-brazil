//
//  PopularMoviesCoordinator.swift
//  Movs
//
//  Created by Gabriel D'Luca on 06/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import Combine

class PopularMoviesCoordinator: Coordinator {
    
    // MARK: - Typealiases
    
    typealias Presenter = UITabBarController
    typealias Controller = PopularMoviesViewController
    
    // MARK: - Properties
    
    internal let dependencies: Dependencies
    internal var movieDetailsCoordinator: MovieDetailsCoordinator!
    internal let coordinatedViewController: Controller
    internal let presenter: Presenter
    
    // MARK: - Publishers and Subscribers
    
    internal var subscribers: [AnyCancellable?] = []
    
    // MARK: - Initializers and Deinitializers
    
    init(parent: HomeTabBarCoordinator) {
        self.presenter = parent.coordinatedViewController
        self.dependencies = parent.dependencies
        
        let viewModel = PopularMoviesControllerViewModel(dependencies: self.dependencies)
        self.coordinatedViewController = PopularMoviesViewController(viewModel: viewModel)
        self.coordinatedViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        viewModel.coordinatorDelegate = self
    }
    
    deinit {
        for subscriber in self.subscribers {
            subscriber?.cancel()
        }
    }
    
    // MARK: - Coordinator
    
    func start() { }
    
    func finish() {
        self.movieDetailsCoordinator = nil
    }
    
    // MARK: - Binding
    
    func bind(to coordinator: MovieDetailsCoordinator) {
        self.subscribers.append(coordinator.$coordinatorDidFinish
            .sink(receiveValue: { isFinishing in
                if isFinishing {
                    self.movieDetailsCoordinator = nil
                }
            })
        )
    }
}

extension PopularMoviesCoordinator: MovieCoordinator {
    func didFavoriteItem(movie: Movie) { }
    
    func didSelectItem(movie: Movie) {
        self.movieDetailsCoordinator = MovieDetailsCoordinator(parent: self, movie: movie)
        self.movieDetailsCoordinator.start()
        self.bind(to: self.movieDetailsCoordinator)
    }
}
