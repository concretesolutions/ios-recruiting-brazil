//
//  TabBarController.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import UIKit


class TabBarController: UITabBarController {
    
    //MARK: - View cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UsedColors.gold.color
        tabBar.tintColor = UsedColors.black.color
        setupTabBar()
    }
    
    //MARK: - Tab Bar Configuration
    func setupTabBar(){
        
        let crud = FavoriteCRUD()
        let apiAccess = APIClient()
        
        let mainController = UINavigationController(rootViewController: MovieGridController(crud: crud, apiAccess: apiAccess))
        mainController.tabBarItem.image = UIImage(named: "list_icon")
        mainController.tabBarItem.title = "Movies"
        mainController.tabBarItem.selectedImage = UIImage(named: "list_icon")
        
        let favController = UINavigationController(rootViewController: FavoriteController(crud: crud))
        favController.tabBarItem.image = UIImage(named: "favorite_empty_icon")
        favController.tabBarItem.title = "Favorites"
        favController.tabBarItem.selectedImage = UIImage(named: "favorite_empty_icon")
        
        viewControllers = [mainController,favController]
    }
    
}
