//
//  TabBarFlowController.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class TabBarFlowController {
    private let tabController: UITabBarController
    private let moviesListNavController = UINavigationController()
//    private let favoritesNavController = UINavigationController()
    
    private let movieService = TMDBMovieService.shared
    
    init(with rootTabBarController: UITabBarController) {
        self.tabController = rootTabBarController
        
        let moviesFlowController = MoviesListFlowController(withService: self.movieService)
        moviesFlowController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon"), tag: 0)
        let favoritesFlowController = FavoritesFlowController(withService: self.movieService)
        favoritesFlowController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite_empty_icon"), tag: 1)
        self.tabController.setViewControllers([moviesFlowController, favoritesFlowController], animated: true)
        
        self.tabController.tabBar.barTintColor = UIColor.appYellow
        self.tabController.tabBar.tintColor = UIColor.appDarkBlue
        self.tabController.tabBar.isTranslucent = false
    }
}
