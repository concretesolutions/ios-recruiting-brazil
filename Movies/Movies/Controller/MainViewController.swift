//
//  MainViewController.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    /// Creates the main view of the app with it`s respective tabs
    private func setupTabBarController(){
        
        /// Sets the selected colour for the icons and the
        self.tabBar.tintColor       = .appColor
        self.tabBar.backgroundColor = .white
        
        /// Creates instances of the View Controllers
        let popularMoviesController   = PopularMoviesViewController()
        let favoriteMoviewsController = FavoriteMoviesViewController()
        
        /// Sets the names for the tabs, the images and their index
        popularMoviesController  .tabBarItem = UITabBarItem(title: "Popular Movies"      , image: UIImage(named: "icon_movie")   , tag: 0)
        favoriteMoviewsController.tabBarItem = UITabBarItem(title: "My Favorites" , image: UIImage(named: "icon_favorite_over"), tag: 1)
        
        /// Adds the ViewControllers to the TabBarController
        self.viewControllers = [popularMoviesController, favoriteMoviewsController].map {
            UINavigationController(rootViewController: $0)
        }
    }
}
