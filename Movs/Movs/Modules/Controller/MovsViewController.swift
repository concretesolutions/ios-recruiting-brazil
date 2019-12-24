//
//  MovsViewController.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 06/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

class MovsViewController: UITabBarController {

    // MARK: - ViewControllers

    let popularMoviesVC = PopularMoviesViewController()
    let favoriteMoviesVC = FavoriteMoviesViewController()

    // MARK: - Life cycle

    override func viewDidLoad() {

        self.tabBar.tintColor = .systemIndigo

        // Popular Movies' screen

        let popularNavController = UINavigationController(rootViewController: self.popularMoviesVC)
        popularNavController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "list.bullet"), tag: 0)
        popularNavController.navigationBar.tintColor = .systemIndigo
        popularNavController.navigationBar.prefersLargeTitles = true
        popularNavController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
        popularNavController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemIndigo]

        // Favorite Movies' screen

        let favoriteNavController = UINavigationController(rootViewController: self.favoriteMoviesVC)
        favoriteNavController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 0)
        favoriteNavController.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        favoriteNavController.navigationBar.tintColor = .systemIndigo
        favoriteNavController.navigationBar.prefersLargeTitles = true
        favoriteNavController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
        favoriteNavController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemIndigo]

        self.viewControllers = [popularNavController, favoriteNavController]
    }
}
