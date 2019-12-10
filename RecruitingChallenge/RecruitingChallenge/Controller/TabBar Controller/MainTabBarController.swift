//
//  MainTabBarController.swift
//  RecruitingChallenge
//
//  Created by Giovane Barreira on 12/7/19.
//  Copyright © 2019 Giovane Barreira. All rights reserved.


import UIKit

class MainTabBarController: UITabBarController {
    
    lazy var favoritesVC: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = false
        return navigationController
    }()
    
    lazy var moviesVC: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = false
        return navigationController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
        setupNavBarStyle()
    }
    
    func setupTabbar() {
        
        moviesVC = UINavigationController(rootViewController: MoviesViewController())
        moviesVC.tabBarItem.image = UIImage(named: "list_icon")
        moviesVC.tabBarItem.title = "Movies"
        
        favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        favoritesVC.tabBarItem.image = UIImage(named: "favorite_empty_icon")
        favoritesVC.tabBarItem.title = "Favorites"
        
        //Set Tabbar Color icon and text
        let selectedColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let unselectedColor = #colorLiteral(red: 0.6077751517, green: 0.6078823209, blue: 0.6077683568, alpha: 1)
        UITabBar.appearance().tintColor = selectedColor
        UITabBar.appearance().unselectedItemTintColor = unselectedColor
        tabBar.barTintColor = UIColor(red: 246/255, green: 205/255, blue: 100/255, alpha: 1.0)
        setViewControllers([moviesVC, favoritesVC], animated: true)
        
    }
    
    func setupNavBarStyle() {
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        standard.backgroundColor = UIColor(red: 246/255, green: 205/255, blue: 100/255, alpha: 1.0)
        standard.titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().standardAppearance = standard
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    }
}
