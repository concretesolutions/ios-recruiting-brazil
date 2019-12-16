//
//  PopularMoviesTabCoordinator.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 14/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

final class PopularMoviesTabCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator]?

    private let navigationController: UINavigationController

    var rootViewController: UIViewController {
        return navigationController
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController

        self.navigationController.tabBarItem = UITabBarItem(
            title: "Movies", image: UIImage(named: "list_icon"), tag: 0)
    }

    func start() {
        let vc = PopularMoviesListViewController()
        navigationController.pushViewController(vc, animated: true)
    }

}
