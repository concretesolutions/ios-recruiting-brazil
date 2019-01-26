//
//  FavoritesCoordinator.swift
//  Movs
//
//  Created by Filipe Jordão on 24/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation
import UIKit

class FavoritesCoordinator {
    let config: MovsConfig

    init(config: MovsConfig) {
        self.config = config
    }

    func create() -> UIViewController {
        let viewController = FavoritesViewController()
        viewController.title = "Favorites"
        viewController.coordinator = self
        _ = FavoritesViewModel(view: viewController, favoriteStore: MovsFavoriteStore(), config: config)
        let navVc = UINavigationController(rootViewController: viewController)

        navVc.navigationBar.barTintColor = .movsYellow

        viewController.tabBarItem = UITabBarItem(title: viewController.title, image: #imageLiteral(resourceName: "favorite_empty_icon"), selectedImage: nil)

        return navVc
    }

    func next(on viewController: UIViewController, with viewModel: FavoriteMovieViewModel) {
        let nextVc = MovieDetailCoordinator(config: config).create(with: viewModel.model)

        if let navVc = viewController.navigationController {
            navVc.pushViewController(nextVc, animated: true)
        } else {
            viewController.present(nextVc, animated: true)
        }
    }
}
