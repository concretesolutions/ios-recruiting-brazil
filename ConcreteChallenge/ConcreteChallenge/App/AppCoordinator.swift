//
//  AppCoordinator.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 18/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

struct AppCoordinator: Coordinator {
    let window: UIWindow
    var rootViewController: UITabBarController

    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.rootViewController = CustomTabBarController()
    }

    func start() {
        let moviesCoordinator = MoviesCoordinator()
        moviesCoordinator.start()

        // TODO: implement favorites
        let favoritesCoordinator = MoviesCoordinator()
        favoritesCoordinator.start()

        rootViewController.viewControllers = [
            moviesCoordinator.rootViewController,
            favoritesCoordinator.rootViewController
        ]

        moviesCoordinator.presenter.tabBarItem.image = UIImage.listIcon
        favoritesCoordinator.presenter.tabBarItem.image = UIImage.Favorite.emptyIcon

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
