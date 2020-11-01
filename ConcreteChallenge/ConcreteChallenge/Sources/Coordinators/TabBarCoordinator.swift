//
//  MoviesCoordinator.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class TabBarCoordinator: Coordinator, TabBarViewControllerDelegate, MoviesViewControllerDelegate {
    private weak var rootController: AppRootController?

    // MARK: - Initializer

    public init(rootController: AppRootController?) {
        self.rootController = rootController
    }

    // MARK: - Coordinator conforms

    func start() {
        let tabBarViewController = TabBarScreenFactory.makeTabBar(tabBarDelegate: self, moviesDelegate: self)
        let navigationController = UINavigationController(rootViewController: tabBarViewController)

        rootController?.rootViewController = navigationController
    }

    // MARK: - TabBarViewControllerDelegate conforms

    func barButtonItemTapped(_ viewController: TabBarViewController) {
        let filterTypeViewController = FilterFactory.makeFilterType()
        pushViewController(viewController: filterTypeViewController)
    }

    // MARK: - MoviesViewControllerDelegate conforms

    func galleryItemTapped(movie: Movie, _ viewController: MoviesViewController) {
        let moviesDetailsViewController = MovieDetailsScreenFactory.makeMoviesDetails(movie: movie)
        pushViewController(viewController: moviesDetailsViewController)
    }

    // MARK: - Private functions

    private func pushViewController(viewController: UIViewController) {
        if let rootController = rootController,
            let rootViewController = rootController.rootViewController,
            let navigationController = rootViewController as? UINavigationController {

            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
