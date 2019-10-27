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
    
    init(with rootTabBarController: UITabBarController) {
        self.tabController = rootTabBarController
        
        let moviesFlowController = MoviesListFlowController()
        moviesFlowController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon"), tag: 0)
        self.tabController.setViewControllers([moviesFlowController], animated: true)
        
        self.tabController.tabBar.barTintColor = UIColor.appYellow
        self.tabController.tabBar.tintColor = UIColor.appDarkBlue
        self.tabController.tabBar.isTranslucent = false
    }
}
