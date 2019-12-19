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
            title: "Filmes populares", image: UIImage(named: "list_icon"), tag: 0)
        self.navigationController.setupStyle()
    }

    func start() {
        guard navigationController.topViewController == nil else { return }
        let vc = PopularMoviesListViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func showDetails(of movie: Movie) {
        let viewModel = MovieDetailsViewModel(movie: movie)
        let vc = MovieDetailsViewController(viewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
