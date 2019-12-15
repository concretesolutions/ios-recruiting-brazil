//
//  TabBarController.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import UIKit

class TabBarController: UITabBarController {
    let trendingMoviesVC = TrendingMoviesViewController()
    let favoriteMoviesVC = FavoriteMoviesViewController()
    lazy var trendingNavigation: UINavigationController = {
        return UINavigationController(rootVC: trendingMoviesVC, color: .customYellow)
    }()
    lazy var favoriteNavigation: UINavigationController = {
       return UINavigationController(rootVC: favoriteMoviesVC, color: .customYellow)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trendingMoviesVC.addFavoriteMovieDelegate = favoriteMoviesVC
        setupTabBar()
    }
    
    func setupTabBar() {
        let listIcon = UIImage(named: "list_icon")
        let favoriteIcon = UIImage(named: "favorite_empty_icon")
        trendingNavigation.tabBarItem = UITabBarItem(title: "Trending", image: listIcon, tag: 0)
        favoriteNavigation.tabBarItem = UITabBarItem(title: "Favorites", image: favoriteIcon, tag: 1)
        
        let controllers = [trendingNavigation, favoriteNavigation]
        viewControllers = controllers
    }
}
