//
//  TabBarController.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import UIKit

//MARK: - Tab Bar Configuration
class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UsedColor.pink.color
        navigationController?.navigationBar.backgroundColor = UsedColor.pink.color
        setupTabBar()
    }
    
    //Set the items in the tab bar
    func setupTabBar(){
        let mainController = UINavigationController(rootViewController: MovieGridController())
        mainController.tabBarItem.image = UIImage(named: "list_icon")
        mainController.tabBarItem.selectedImage = UIImage(named: "list_icon")
        
        let favController = UINavigationController(rootViewController: FavoriteController())
        favController.tabBarItem.image = UIImage(named: "favorite_empty_icon")
        favController.tabBarItem.selectedImage = UIImage(named: "favorite_empty_icon")
        
        viewControllers = [mainController,favController]
    }
    
}
