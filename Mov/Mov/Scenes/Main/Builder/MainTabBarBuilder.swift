//
//  MainTabBarBuilder.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

class MainTabBarBuilder {
    static func build() -> MainTabBarController {
        let movieGridVC = MovieGridBuilder.build()
        let movieGridNavigationController = DefaultNavigationController(rootViewController: movieGridVC)
        
        let favoritesVC = FavoritesBuilder.build()
        let favoritesNavigationController = DefaultNavigationController(rootViewController: favoritesVC)
        
        let tabBarVC = MainTabBarController()
        tabBarVC.viewControllers = [favoritesNavigationController, movieGridNavigationController]
        
        return tabBarVC
    }
}
