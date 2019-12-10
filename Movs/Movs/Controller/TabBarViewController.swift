//
//  TabBarViewController.swift
//  Movs
//
//  Created by Lucca Ferreira on 02/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    private let moviesViewController: MoviesViewController = {
        let moviesViewController = MoviesViewController()
        moviesViewController.title = "Movs"
        moviesViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film"), tag: 0)
        return moviesViewController
    }()

    private let favoritesViewController: FavoritesViewController = {
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.title = "Favorites"
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 1)
        return favoritesViewController
    }()

    required init() {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = [moviesViewController, favoritesViewController].map { navigationController(for: $0) }
        self.tabBar.isTranslucent = true
        self.tabBar.tintColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Creates and setup a UINavigationController for a UIViewController
    /// - Parameter controller: UIViewController that will receive the UINavigationController
    private func navigationController(for controller: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .always
        return navigationController
    }

}
