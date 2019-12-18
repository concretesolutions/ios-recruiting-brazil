//
//  AppCoordinator.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 13/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

final class AppCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator]?

    private let tabBarController: UITabBarController

    var rootViewController: UIViewController {
        return tabBarController
    }

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.childCoordinators = [
            PopularMoviesTabCoordinator(navigationController: UINavigationController()),
            FavoriteMoviesTabCoordinator(navigationController: UINavigationController())
        ]

        super.init()

        self.tabBarController.viewControllers = self.childCoordinators?.map { $0.rootViewController }
        self.tabBarController.delegate = self
        self.tabBarController.setupStyle()
    }

    func start() {
        let firstCoordinator = childCoordinators?.first
        firstCoordinator?.start()
    }
}

// MARK: - UITabBarControllerDelegate
extension AppCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let coordinator = childCoordinators?.first(where: { $0.rootViewController == viewController })
        coordinator?.start()
    }
}
