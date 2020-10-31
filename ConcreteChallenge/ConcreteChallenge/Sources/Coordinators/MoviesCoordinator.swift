//
//  MoviesCoordinator.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class MoviesCoordinator: Coordinator, MoviesViewControllerDelegate {
    private weak var rootController: AppRootController?

    // MARK: - Initializer

    public init(rootController: AppRootController?) {
        self.rootController = rootController
    }

    // MARK: - Coordinator conforms

    func start() {
        let tabBarViewController = TabBarScreenFactory.makeTabBar(delegate: self)
        let navigationController = UINavigationController(rootViewController: tabBarViewController)

        rootController?.rootViewController = navigationController
    }

    // MARK: - MoviesViewControllerDelegate conforms

    func galleryItemTapped(movie: Movie, _ viewController: MoviesViewController) {
        let moviesDetailsViewController = MovieDetailsScreenFactory.makeMoviesDetails(movie: movie)

        if let rootController = rootController,
            let rootViewController = rootController.rootViewController,
            let navigationController = rootViewController as? UINavigationController {

            navigationController.pushViewController(moviesDetailsViewController, animated: true)
        }
    }
}
