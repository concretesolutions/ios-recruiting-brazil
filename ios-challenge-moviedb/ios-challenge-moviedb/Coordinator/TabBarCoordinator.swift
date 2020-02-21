//
//  TabBarCoordinator.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 20/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    var rootViewController: UIViewController
        
    // Tem que especificar as classes
    private let moviesCoordinator: MoviesCoordinator
    private let favoritesCoordinator: FavoritesCoordinator
    
    init() {
        self.rootViewController = TabBarController()
        self.moviesCoordinator = MoviesCoordinator()
        self.favoritesCoordinator = FavoritesCoordinator()
        
        setupTabBar()
    }
    
    func start() {
    }
    
    private func setupTabBar() {
        let moviesViewController = moviesCoordinator.rootViewController
        let favoritesViewController = favoritesCoordinator.rootViewController
        
        let moviesItem = UITabBarItem(title: "Movies",
                                      image: UIImage(named: "list_icon"),
                                      selectedImage: UIImage(named: "list_icon"))
        
        let favoritesItem = UITabBarItem(title: "Favorites",
                                         image: UIImage(named: "favorite_empty_icon"),
                                         selectedImage: UIImage(named: "favorite_empty_icon"))
        
        moviesViewController.tabBarItem = moviesItem
        favoritesViewController.tabBarItem = favoritesItem
        
        var controllers: [UIViewController] = []
        controllers.append(moviesViewController)
        controllers.append(favoritesViewController)
        
        guard let tabBarController = rootViewController as? TabBarController else { return }
        tabBarController.viewControllers = controllers
    }
}
