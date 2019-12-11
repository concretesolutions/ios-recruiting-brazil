//
//  TabBarController.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import UIKit

class TabBarController: UITabBarController {
    
    let trendingMoviesVC = UINavigationController(rootVC: TrendingMoviesViewController(), color: .customYellow)
    let favoriteMoviesVC = UINavigationController(rootVC: FavoriteMoviesViewController(), color: .customYellow)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let listIcon = UIImage(named: "list_icon")
        let favoriteIcon = UIImage(named: "favorite_empty_icon")
        trendingMoviesVC.tabBarItem = UITabBarItem(title: "Trending", image: listIcon, tag: 0)
        favoriteMoviesVC.tabBarItem = UITabBarItem(title: "Favorites", image: favoriteIcon, tag: 1)
        
        let controllers = [trendingMoviesVC, favoriteMoviesVC]
        viewControllers = controllers
    }
}
