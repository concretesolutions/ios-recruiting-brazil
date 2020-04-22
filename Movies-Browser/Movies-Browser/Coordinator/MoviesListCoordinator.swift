//
//  MoviesListCoordinator.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 18/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit

final class MoviesListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var tabBarController: MainTabBarController?
    var viewModel: MoviesListViewModel
    
    init(tabBarController: MainTabBarController) {
        self.navigationController = tabBarController.navigationController ?? UINavigationController()
        self.tabBarController = tabBarController
        self.viewModel = MoviesListViewModel(callback: nil)
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "MoviesList", bundle: Bundle.main)
        if let viewController = storyboard.instantiateInitialViewController() as? MoviesListViewController {
            viewController.coordinator = self
            viewController.viewModel = self.viewModel
            viewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list"), tag: 0)
            tabBarController?.viewControllers = [viewController]
            tabBarController?.selectedIndex = 0
        }
    }
}

// MARK: - MovieDetailCoordinator -
extension MoviesListCoordinator {
    func startMovieDetail(movie: Movie){
        let child = MovieDetailCoordinator(navigationController: navigationController, movie: movie)
        childCoordinators.append(child)
        child.start()
    }
}
