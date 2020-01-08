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
        movies.view.backgroundColor = .red
        movies.title = NSLocalizedString("Movies", comment: "Title Movies")
        
        let favorites = FavoritesViewController.init()
        favorites.view.backgroundColor = .blue
        favorites.title = NSLocalizedString("Favorites", comment: "Title Favorites")

        
        let listControllers = [movies,favorites]
        
        viewControllers = listControllers.map({ (controller) in
            UINavigationController.init(rootViewController: controller)
        })
    }
}

