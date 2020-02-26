//
//  AppCoordinator.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 20/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit

/**
 Root Coordinator
 */
class AppCoordinator: Coordinator {
    
    var window: UIWindow
    var rootViewController: UIViewController
        
    private let moviesCoordinator: MoviesCoordinator
    private let favoritesCoordinator: FavoritesCoordinator
    
    init() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        self.rootViewController = TabBarController()
        self.moviesCoordinator = MoviesCoordinator()
        self.favoritesCoordinator = FavoritesCoordinator()
        
        setupWindow()
        setupTabBar()
    }
    
    func start() {
        
    }
    
    // MARK: - Setup Window
    private func setupWindow() {
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }
    
    // MARK: - Setup Tab Bar
    private func setupTabBar() {
        let moviesViewController = moviesCoordinator.rootViewController
        let favoritesViewController = favoritesCoordinator.rootViewController
        
        let moviesNavigation = UINavigationController(rootViewController: moviesViewController)
        let favoritesNavigation = UINavigationController(rootViewController: favoritesViewController)
        
        moviesNavigation.navigationBar.prefersLargeTitles = true
        moviesNavigation.navigationBar.isTranslucent = false
        moviesNavigation.navigationItem.largeTitleDisplayMode = .automatic
        moviesNavigation.navigationBar.tintColor = .white
        
        favoritesNavigation.navigationBar.prefersLargeTitles = true
        favoritesNavigation.navigationBar.isTranslucent = false

        let moviesItem = UITabBarItem(title: "Movies",
                                      image: UIImage(named: "list_icon"),
                                      selectedImage: UIImage(named: "list_icon"))
        
        let favoritesItem = UITabBarItem(title: "Favorites",
                                         image: UIImage(named: "favorite_empty_icon"),
                                         selectedImage: UIImage(named: "favorite_empty_icon"))
        
        moviesNavigation.tabBarItem = moviesItem
        favoritesNavigation.tabBarItem = favoritesItem
        
        var controllers: [UIViewController] = []
        controllers.append(moviesNavigation)
        controllers.append(favoritesNavigation)
        
        guard let tabBarController = rootViewController as? TabBarController else { return }
        tabBarController.viewControllers = controllers        
    }
}
