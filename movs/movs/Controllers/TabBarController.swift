//
//  TabBarController.swift
//  movs
//
//  Created by Emerson Victor on 04/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - View controller life cycle
    override func loadView() {
        super.loadView()
        
        // Movies controller
        let moviesController = MoviesController()
        moviesController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let moviesNavigationController = UINavigationController(rootViewController: moviesController)
        moviesNavigationController.navigationBar.prefersLargeTitles = true
        moviesNavigationController.navigationBar.tintColor = .label
        
        // Favorites controller
        let favoritesController = FavoritesController()
        favoritesController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesController)
        favoritesNavigationController.navigationBar.prefersLargeTitles = true
        favoritesNavigationController.navigationBar.tintColor = .label
        
        // Setup tab bar
        self.viewControllers = [moviesNavigationController,
                           favoritesNavigationController]
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .label
    }
}
