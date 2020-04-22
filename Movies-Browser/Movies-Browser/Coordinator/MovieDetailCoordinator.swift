//
//  MovieDetailCoordinator.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 18/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit

final class MovieDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var viewModel: MovieDetailViewModel
    
    init(navigationController: UINavigationController, movie: Movie) {
        self.navigationController = navigationController
        self.viewModel = MovieDetailViewModel(movie: movie, callback: nil)
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: Bundle.main)
        if let viewController = storyboard.instantiateInitialViewController() as? MovieDetailViewController {
            viewController.coordinator = self
            viewController.viewModel = self.viewModel
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
