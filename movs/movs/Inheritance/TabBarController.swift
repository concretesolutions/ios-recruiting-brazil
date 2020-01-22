//
//  TabBarController.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let movieNavigation = NavigationController(rootViewController: MoviesViewController())
        movieNavigation.tabBarItem = UITabBarItem(title: Localizable.movies, image: .listIcon, selectedImage: nil)
        
        let favoriteNavigation = NavigationController(rootViewController: FavoritesViewController())
        favoriteNavigation.tabBarItem = UITabBarItem(title: Localizable.favorites, image: .favoriteEmptyIcon, selectedImage: nil)
        
        self.viewControllers = [movieNavigation, favoriteNavigation]
        
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .primary

        self.tabBar.tintColor = .black
        
    }
    

}
