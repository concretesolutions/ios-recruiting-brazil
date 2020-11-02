//
//  MoviesCoordinator.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class TabBarCoordinator: Coordinator, TabBarViewControllerDelegate, MoviesViewControllerDelegate, FilterViewControllerDelegate {
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
        let filterTypeViewController = FilterScreenFactory.makeFilterType(delegate: self)
        pushViewController(viewController: filterTypeViewController, true)
    }

    func filterApplyButtonTapped(filter: FilterSearch, _ viewController: TabBarViewController) {
        if let viewController = viewController.selectedViewController as? MoviesViewController {
            viewController.filter(search: filter.search ?? .empty)
        } else if let viewController = viewController.selectedViewController as? FavoritesViewController {
            viewController.filter(newFilter: filter)
        } else {
            print(Strings.viewControllerNotFound.localizable)
        }
    }

    // MARK: - MoviesViewControllerDelegate conforms

    func galleryItemTapped(movie: Movie, _ viewController: MoviesViewController) {
        let moviesDetailsViewController = MovieDetailsScreenFactory.makeMoviesDetails(movie: movie)
        pushViewController(viewController: moviesDetailsViewController, true)
    }

    // MARK: - FilterViewControllerDelegate conforms

    func filterApplyButtonTapped(filter: FilterSearch, _ viewController: FilterViewController) {
        let viewController = fetchViewController(TabBarViewController.self)
        if let viewController = viewController {
            popToViewController(viewController: viewController, true)
            viewController.filter(filter: filter)
        }
    }

    // MARK: - Private functions

    private func pushViewController(viewController: UIViewController, _ animated: Bool) {
        if let rootController = rootController,
            let rootViewController = rootController.rootViewController,
            let navigationController = rootViewController as? UINavigationController {

            navigationController.pushViewController(viewController, animated: animated)
        }
    }

    private func popToViewController(viewController: UIViewController, _ animated: Bool) {
        if let rootController = rootController,
            let rootViewController = rootController.rootViewController,
            let navigationController = rootViewController as? UINavigationController {

            navigationController.popToViewController(viewController, animated: animated)
        }
    }

    private func fetchViewController<T: UIViewController>(_ type: T.Type)  -> T? {
        if let rootController = rootController,
            let rootViewController = rootController.rootViewController,
            let navigationController = rootViewController as? UINavigationController {

            let viewController = navigationController.viewControllers.first { $0 is T }
            if let viewController = viewController as? T {
                return viewController
            }
        }

        return nil
    }
}
