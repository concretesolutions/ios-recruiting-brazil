//
//  MovTabBarController.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit

class MovTabBarController: UITabBarController, UITabBarControllerDelegate{
    

    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        
        setTabs()
    
    }
    

    
    func setTabs(){
        
        let moviesViewController = MoviesViewController()
        moviesViewController.title = "Movies"
        moviesViewController.tabBarItem.image = UIImage(named: "list_icon")
       // moviesViewController.tabBarItem.selectedImage = UIImage(named: "list_icon")
        
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.title = "Favorites"
        favoritesViewController.tabBarItem.image = UIImage(named: "favorite_emply_icon")
       // favoritesViewController.tabBarItem.selectedImage = UIImage(named: "favorite_emply_icon")
        
        
        let controllers = [moviesViewController, favoritesViewController]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        
        
    }
    
    
}
