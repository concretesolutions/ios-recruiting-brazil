//
//  MainTabBarViewController.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 12/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        
    }

    // MARK: Class functions
    
    private func configView() {
        let moviesCollectionViewController = MoviesCollectionCollectionViewController()
        let tabBar1 = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        moviesCollectionViewController.tabBarItem = tabBar1
        let favoritesTableViewController = FavoritesTableViewController()
        let tabBar2 = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        favoritesTableViewController.tabBarItem = tabBar2
        self.viewControllers = [moviesCollectionViewController, favoritesTableViewController]
    }
    
}
