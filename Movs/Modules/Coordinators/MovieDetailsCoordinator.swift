//
//  PopularMoviesCoordinator.swift
//  Movs
//
//  Created by Gabriel D'Luca on 06/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class MovieDetailsCoordinator: Coordinator {

    // MARK: - Typealiases
    
    typealias Presenter = UIViewController
    typealias Controller = MovieDetailsViewController
    
    // MARK: - Properties
    
    internal var coordinatedViewController: Controller
    internal var presenter: Presenter
    
    // MARK: - Initializers and Deinitializers
    
    init(presenter: UIViewController, movie: Movie, apiManager: MoviesAPIManager) {
        self.presenter = presenter
        let viewModel = MovieDetailsControllerViewModel(movie: movie, apiManager: apiManager)
        self.coordinatedViewController = MovieDetailsViewController(viewModel: viewModel)
    }
    
    // MARK: - Coordination
    
    func start() {
        self.presenter.present(self.coordinatedViewController, animated: true, completion: nil)
    }
}
