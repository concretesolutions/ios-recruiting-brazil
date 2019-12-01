//
//  TabBarViewController.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create View Controllers
        let movieListViewController = MovieListViewController()
        let favoriteListViewController = FavoriteListViewController()
        
        // Set the View Controllers' tab items
        movieListViewController.tabBarItem = UITabBarItem(title: "Movies",
                                                          image: UIImage(systemName: "list.bullet"),
                                                          tag: 0)
        favoriteListViewController.tabBarItem = UITabBarItem(title: "Favorites",
                                                             image: UIImage(systemName: "heart.fill"),
                                                             tag: 1)
        
        // Set the Tab Bar Controller tab items        
        viewControllers = [movieListViewController, favoriteListViewController]
    }
}
