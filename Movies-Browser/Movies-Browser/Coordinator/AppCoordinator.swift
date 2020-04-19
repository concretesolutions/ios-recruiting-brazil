//
//  AppCoordinator.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 18/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.startTabBar()
    }
}

// MARK: - MainTabBarCoordinator -
extension AppCoordinator {
    func startTabBar(){
        let child = MainTabBarCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
    }
}
