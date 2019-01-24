//
//  TabBarCoordinator.swift
//  Movs
//
//  Created by Filipe Jordão on 23/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit

class TabBarCoordinator {
    func create(with config: TheMovieDBConfig) -> UIViewController {
        let tabBar = UITabBarController()
        tabBar.tabBar.barTintColor = .movsYellow
        tabBar.tabBar.tintColor = .movsBlack
        tabBar.tabBar.unselectedItemTintColor = .movsGray
        tabBar.viewControllers = [PopularMoviesCoordinator(config: config).create(),
                                  PopularMoviesCoordinator(config: config).create()]

        return tabBar
    }
}
