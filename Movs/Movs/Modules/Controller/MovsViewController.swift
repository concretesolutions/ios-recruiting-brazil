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

    // MARK: - Life cycle

    override func viewDidLoad() {

        // Popular Movies' screen

        let popularNavController = UINavigationController(rootViewController: self.popularMoviesVC)
        popularNavController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "list.bullet"), tag: 0)
        popularNavController.navigationBar.prefersLargeTitles = true

        // Favorite Movies' screen

        // TODO: add Favorite Movies's screen

        self.viewControllers = [popularNavController]
    }
}
