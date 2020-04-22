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
    var viewModel: FavoritesListViewModel
    
    init(tabBarController: MainTabBarController) {
        self.navigationController = tabBarController.navigationController ?? UINavigationController()
        self.tabBarController = tabBarController
        self.viewModel = FavoritesListViewModel(callback: nil)
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "FavoritesList", bundle: Bundle.main)
        if let viewController = storyboard.instantiateInitialViewController() as? FavoritesListViewController {
            viewController.coordinator = self
            viewController.viewModel = self.viewModel
            viewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "star-filled"), tag: 0)
            tabBarController?.viewControllers?.append(viewController)
        }
    }
}

// MARK: - MovieDetailCoordinator -
extension FavoritesListCoordinator {
    func startMovieDetail(movie: Movie){
        let child = MovieDetailCoordinator(navigationController: navigationController, movie: movie)
        childCoordinators.append(child)
        child.start()
    }
}
