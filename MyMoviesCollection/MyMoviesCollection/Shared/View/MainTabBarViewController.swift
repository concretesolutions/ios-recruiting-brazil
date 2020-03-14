//
//  MainTabBarViewController.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 12/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    // MARK: - Class functions
    
    private func configView() {
        self.tabBar.barTintColor = ColorSystem.cYellowDark
        self.tabBar.tintColor = ColorSystem.cBlueDark
        let moviesCollectionViewController = MoviesCollectionCollectionViewController(collectionViewLayout: MoviesListFlowLayout())
        let tabBar1 = UITabBarItem(title: "Movies", image: #imageLiteral(resourceName: "list_icon"), tag: 0)
        moviesCollectionViewController.tabBarItem = tabBar1
        let favoritesTableViewController = FavoritesTableViewController()
        let tabBar2 = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "favorite_empty_icon"), tag: 1)
        favoritesTableViewController.tabBarItem = tabBar2
        self.viewControllers = [moviesCollectionViewController, favoritesTableViewController]
    }
    
}
