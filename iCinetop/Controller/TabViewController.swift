//
//  tabViewController.swift
//  iCinetop
//
//  Created by Alcides Junior on 14/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UIColor(named: "1dblackCustom")
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor(named: "whiteCustom")

    }
    
     override func viewWillAppear(_ animated: Bool) {
            let moviesViewController = UINavigationController(rootViewController: MoviesViewController())
            let favoritesViewController = UINavigationController(rootViewController: FavoritesViewController())
            moviesViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list.bullet"), selectedImage: UIImage(named: "list.bullet"))
            
            favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "star"), selectedImage: UIImage(named: "star.fill"))
            
            let controllers = [moviesViewController, favoritesViewController]
            self.viewControllers = controllers
        
        
    }
}
