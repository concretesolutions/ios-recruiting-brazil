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

        moviesViewController.tabBarItem = UITabBarItem(title: "Movs", image: UIImage(named: "movs_tab_3"), tag: 0)
//        moviesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        return moviesViewController
    }()

    private let favoritesViewController: FavoritesViewController = {
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.title = "Favorites"
//        favoritesViewController.tabBarItem = UITabBarItem(title: "Movs", image: UIImage(named: ""), tag: 0)
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return favoritesViewController
    }()

    required init() {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = [moviesViewController, favoritesViewController].map { navigationController(for: $0) }
        self.tabBar.unselectedItemTintColor = UIColor.systemOrange.withAlphaComponent(0.3)
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func navigationController(for controller: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .automatic
        return navigationController
    }

}
