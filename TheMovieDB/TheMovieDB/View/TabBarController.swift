//
//  TabBarController.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 07/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        addItemsInTabBar()
    }
    
    private func addItemsInTabBar() {
        let movies = MoviesViewController.init()
        movies.title = NSLocalizedString("Movies", comment: "Title Movies")
        
        let favorites = FavoritesViewController.init()
        favorites.title = NSLocalizedString("Favorites", comment: "Title Favorites")

        let tabItemMovies = UITabBarItem.init(tabBarSystemItem: .mostRecent, tag: 0)
        movies.tabBarItem = tabItemMovies
        
        let tabItemFavorites = UITabBarItem.init(tabBarSystemItem: .favorites, tag: 1)
        favorites.tabBarItem = tabItemFavorites
        
        let listControllers = [movies,favorites]
        
        viewControllers = listControllers.map({ (controller) in
            UINavigationController.init(rootViewController: controller)
        })
    }
}

