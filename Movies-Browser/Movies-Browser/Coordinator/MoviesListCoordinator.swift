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
    
    init(tabBarController: MainTabBarController) {
        self.navigationController = tabBarController.navigationController!
        self.tabBarController = tabBarController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "MoviesList", bundle: Bundle.main)
        if let viewController = storyboard.instantiateInitialViewController() as? MoviesListViewController {
            viewController.coordinator = self
            viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
            tabBarController?.viewControllers = [viewController]
            tabBarController?.selectedIndex = 0
        }
    }
}

// MARK: - MovieDetailCoordinator -
extension MoviesListCoordinator {
    func startMovieDetail(){
        let child = MovieDetailCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
    }
}
