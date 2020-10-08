//
//  TabBarViewController.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import UIKit

class TabBarViewController: UITabBarController {

    private let moviesController: MoviesListController = {
            let layout = UICollectionViewFlowLayout()
            let moviesController = MoviesListController(collectionViewLayout: layout)
            moviesController.title = "Popular Movies"
            moviesController.tabBarItem = UITabBarItem(title: "Popular Movies", image: UIImage(named: "list_icon"), tag: 0)
            return moviesController
        }()

        private let favoritesController: FavoritesController = {
            let favoritesController = FavoritesController()
            favoritesController.title = "Favorites"
            favoritesController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite_empty_icon"), tag: 1)
            return favoritesController
        }()
        
        required init() {
            super.init(nibName: nil, bundle: nil)
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            viewControllers = [moviesController, favoritesController].map { navigationController(for: $0) }
            tabBar.isTranslucent = true
            tabBar.tintColor = .systemBlue
            tabBar.barTintColor = .white
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func navigationController(for controller: UIViewController) -> UINavigationController {
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationItem.largeTitleDisplayMode = .always
            navigationController.navigationBar.barTintColor = .white
            return navigationController
        }
}
