//
//  FavoriteMoviesTabCoordinator.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 14/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

final class FavoriteMoviesTabCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator]?

    private let navigationController: UINavigationController

    var rootViewController: UIViewController {
        return navigationController
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController

        self.navigationController.tabBarItem = UITabBarItem(
            title: "Favorites", image: UIImage(named: "favorite_empty_icon"), tag: 1)
    }

    func start() {
        let vc = FavoriteMoviesListViewController()
        navigationController.pushViewController(vc, animated: true)
    }

}

