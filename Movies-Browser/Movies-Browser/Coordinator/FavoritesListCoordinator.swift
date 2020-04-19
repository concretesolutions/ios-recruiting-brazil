//
//  FavoritesListCoordinator.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 18/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit

final class FavoritesListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var tabBarController: MainTabBarController?
    
    init(tabBarController: MainTabBarController) {
        self.navigationController = tabBarController.navigationController!
        self.tabBarController = tabBarController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "FavoritesList", bundle: Bundle.main)
        if let viewController = storyboard.instantiateInitialViewController() as? FavoritesListViewController {
            viewController.coordinator = self
            viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
            tabBarController?.viewControllers?.append(viewController)
        }
    }
}

// MARK: - MovieDetailCoordinator -
extension FavoritesListCoordinator {
    func startMovieDetail(){
        let child = MovieDetailCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
    }
}
