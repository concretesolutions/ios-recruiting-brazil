//
//  HomeViewController.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 25/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        let moviesVC = MoviesViewController()
        moviesVC.tabBarItem = UITabBarItem(title: "movies".localized, image: UIImage(named: "list_icon"), tag: 1)
        
        let favoriteVC = FavoriteViewController()
        favoriteVC.tabBarItem = UITabBarItem(title: "favorites".localized, image: UIImage(named: "favorite_empty_icon"), tag: 1)
        
        viewControllers = [moviesVC, favoriteVC]
    }
}
