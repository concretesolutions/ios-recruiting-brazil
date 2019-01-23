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
        tabBar.tabBar.barTintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        tabBar.viewControllers = [PopularMoviesCoordinator().create()]

        return tabBar
    }
}
