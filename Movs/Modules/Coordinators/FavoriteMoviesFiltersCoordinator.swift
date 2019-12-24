//
//  FavoriteMoviesFiltersCoordinator.swift
//  Movs
//
//  Created by Gabriel D'Luca on 20/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import Combine

class FavoriteMoviesFiltersCoordinator: ModalCoordinator {
    
    // MARK: - Typealiases
    
    typealias Presenter = UIViewController
    typealias Controller = FavoriteMoviesFiltersViewController
    
    // MARK: - Properties
    
    internal let dependencies: Dependencies
    internal var filters: Filters
    internal var coordinatedViewController: Controller
    internal var presenter: Presenter
    
    // MARK: - Publishers and Subscribers
    
    @Published var coordinatorDidFinish: Bool = false
    internal var finishingPublisher: Published<Bool>.Publisher {
        return $coordinatorDidFinish
    }
    
    // MARK: - Initializers and Deinitializers
    
    init<Parent: Coordinator>(parent: Parent, filters: Filters) {
        self.presenter = parent.coordinatedViewController
        self.dependencies = parent.dependencies
        self.filters = filters
                
        let viewModel = FavoriteMoviesFiltersControllerViewModel(dependencies: self.dependencies)
        self.coordinatedViewController = FavoriteMoviesFiltersViewController(viewModel: viewModel)
        
        viewModel.coordinator = self
    }
    
    // MARK: - Coordinator
    
    func start() {
        self.presenter.present(self.coordinatedViewController, animated: true)
    }
    
    func finish() {
        self.coordinatorDidFinish = true
    }
}
