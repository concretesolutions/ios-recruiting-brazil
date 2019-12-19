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
            title: "Favoritados", image: UIImage(named: "favorite_empty_icon"), tag: 1)
        self.navigationController.setupStyle()
    }

    func start() {
        guard navigationController.topViewController == nil else { return }
        let vc = FavoriteMoviesListViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func showDetails(of favoritedMovie: FavoriteMovie) {
        let viewModel = MovieDetailsViewModel(favoritedMovie: favoritedMovie)
        let vc = MovieDetailsViewController(viewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

}
