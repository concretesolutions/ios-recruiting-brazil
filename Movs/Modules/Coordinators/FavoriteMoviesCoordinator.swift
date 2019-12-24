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
    internal let coordinatedViewController: Controller
    internal let presenter: Presenter
    
    // MARK: - Child Coordinators
    
    internal var filtersCoordinator: FavoriteMoviesFiltersCoordinator!
    internal var movieDetailsCoordinator: MovieDetailsCoordinator!
    
    // MARK: - Publishers and Subscribers
    
    @Published var filters: Filters = Filters()
    internal var subscribers: [AnyCancellable?] = []
    
    // MARK: - Initializers and Deinitializers
    
    init(parent: AppCoordinator) {
        self.presenter = parent.coordinatedViewController
        self.dependencies = parent.dependencies
        
        let viewModel = FavoriteMoviesControllerViewModel(dependencies: self.dependencies)
        let controller = FavoriteMoviesViewController(viewModel: viewModel)
        self.coordinatedViewController = UINavigationController(rootViewController: controller)
        self.coordinatedViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        viewModel.modalPresenter = self
        self.bind(to: viewModel)
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
    
    func bind(to viewModel: FavoriteMoviesControllerViewModel) {
        self.subscribers.append(self.$filters
            .sink(receiveValue: { newFilter in
                viewModel.applyFilter(newFilter)
            })
        )
    }

    func bind(to modalCoordinator: FavoriteMoviesFiltersCoordinator) {
        self.subscribers.append(modalCoordinator.finishingPublisher
            .sink(receiveValue: { finished in
                if finished {
                    self.filters = self.filtersCoordinator.filters
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

// MARK: - ModalPresenterDelegate

extension FavoriteMoviesCoordinator: ModalPresenterDelegate {
    func showFilters() {
        self.filtersCoordinator = FavoriteMoviesFiltersCoordinator(parent: self, filters: self.filters)
        self.filtersCoordinator.start()
        self.bind(to: self.filtersCoordinator)
    }
    
    func showMovieDetails(movie: Movie) {
        self.movieDetailsCoordinator = MovieDetailsCoordinator(parent: self, movie: movie)
        self.movieDetailsCoordinator.start()
        self.bind(to: self.movieDetailsCoordinator)
    }
}
