//
//  MainTabBarCoordinator.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 18/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var tabBarController: MainTabBarController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = MainTabBarController()
    }
    
    func start() {
        tabBarController.coordinator = self
        navigationController.pushViewController(tabBarController, animated: true)
        startMoviesList()
        startFavoritesList()
    }
}


// MARK: - MoviesListCoordinator -
extension MainTabBarCoordinator {
    func startMoviesList(){
        let child = MoviesListCoordinator(tabBarController: tabBarController)
        childCoordinators.append(child)
        child.start()
    }
}

// MARK: - FavoritesListCoordinator -
extension MainTabBarCoordinator {
    func startFavoritesList(){
        let child = FavoritesListCoordinator(tabBarController: tabBarController)
        childCoordinators.append(child)
        child.start()
    }
}
