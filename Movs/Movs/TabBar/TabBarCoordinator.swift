//
//  TabBarCoordinator.swift
//  Movs
//
//  Created by Filipe Jordão on 23/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit

class TabBarCoordinator {
    func create() -> UIViewController {
        let tabBar = UITabBarController()
        tabBar.tabBar.barTintColor = .movsYellow
        tabBar.tabBar.tintColor = .movsBlack
        tabBar.tabBar.unselectedItemTintColor = .movsGray
        tabBar.viewControllers = [PopularMoviesCoordinator().create(),
                                  PopularMoviesCoordinator().create()]

        return tabBar
    }
}
