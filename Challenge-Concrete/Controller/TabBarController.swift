//
//  TabBarController.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import UIKit

class TabBarController: UITabBarController {
    let trendingMoviesVC = UINavigationController(rootViewController: TrendingMoviesViewController())
    let favoriteMoviesVC = UINavigationController(rootViewController: FavoriteMoviesViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendingMoviesVC.tabBarItem = UITabBarItem(title: "Trending", image: UIImage(), selectedImage: UIImage())
        favoriteMoviesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(), selectedImage: UIImage())
        
        let controllers = [trendingMoviesVC, favoriteMoviesVC]
        viewControllers = controllers
    }
}
