//
//  PopularMoviesCoordinator.swift
//  Movs
//
//  Created by Filipe Jordão on 23/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit

class PopularMoviesCoordinator {
    let config: MovsConfig
    init(config: MovsConfig) {
        self.config = config
    }

    func create() -> UIViewController {
        let viewController = PopularMoviesViewController()
        viewController.title = "Popular"
        let provider = TheMovieDBProvider()
        let navVc = UINavigationController(rootViewController: viewController)
        viewController.coordinator = self

        navVc.navigationBar.barTintColor = .movsYellow

        _ = MovieListViewModel(view: viewController,
                               dataProvider: provider,
                               config: config,
                               favoriteStore: MovsFavoriteStore())

        viewController.tabBarItem = UITabBarItem(title: viewController.title, image: #imageLiteral(resourceName: "list_icon"), selectedImage: nil)

        return navVc
    }

    func next(on viewController: UIViewController, with viewModel: MovieViewModel) {
        let nextVc = MovieDetailCoordinator(config: config).create(with: viewModel.model)

        if let navVc = viewController.navigationController {
            navVc.pushViewController(nextVc, animated: true)
        } else {
            viewController.present(nextVc, animated: true)
        }
    }
}
