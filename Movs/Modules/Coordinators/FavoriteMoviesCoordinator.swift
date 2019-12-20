//
//  FavoriteMoviesCoordinator.swift
//  Movs
//
//  Created by Gabriel D'Luca on 06/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import Combine

class FavoriteMoviesCoordinator: Coordinator {

    // MARK: - Typealiases
    
    typealias Presenter = UITabBarController
    typealias Controller = UINavigationController
    
    // MARK: - Properties
    
    internal let dependencies: Dependencies
    internal var filtersCoordinator: FavoriteMoviesFiltersCoordinator!
    internal var movieDetailsCoordinator: MovieDetailsCoordinator!
    internal let coordinatedViewController: Controller
    internal let presenter: Presenter
    
    // MARK: - Publishers and Subscribers
    
    internal var subscribers: [AnyCancellable?] = []
    
    // MARK: - Initializers and Deinitializers
    
    init(parent: AppCoordinator) {
        self.presenter = parent.coordinatedViewController
        self.dependencies = parent.dependencies
        
        let viewModel = FavoriteMoviesControllerViewModel(dependencies: self.dependencies)
        let controller = FavoriteMoviesViewController(viewModel: viewModel)
        self.coordinatedViewController = UINavigationController(rootViewController: controller)
        self.coordinatedViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        viewModel.modalPresenter = self
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

    func bind(to modalCoordinator: FavoriteMoviesFiltersCoordinator) {
        self.subscribers.append(modalCoordinator.finishingPublisher
            .sink(receiveValue: { finished in
                if finished {
                    self.filtersCoordinator = nil
                }
            })
        )
    }
    
    func bind(to modalCoordinator: MovieDetailsCoordinator) {
        self.subscribers.append(modalCoordinator.finishingPublisher
            .sink(receiveValue: { finished in
                if finished {
                    self.movieDetailsCoordinator = nil
                }
            })
        )
    }
}

extension FavoriteMoviesCoordinator: ModalPresenterDelegate {
    func showFilters() {
        self.filtersCoordinator = FavoriteMoviesFiltersCoordinator(parent: self)
        self.filtersCoordinator.start()
        self.bind(to: self.filtersCoordinator)
    }
    
    func showMovieDetails(movie: Movie) {
        self.movieDetailsCoordinator = MovieDetailsCoordinator(parent: self, movie: movie)
        self.movieDetailsCoordinator.start()
        self.bind(to: self.movieDetailsCoordinator)
    }
}
