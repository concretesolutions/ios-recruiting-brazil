//
//  MovTabBarController.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit

class MovTabBarController: UITabBarController, UITabBarControllerDelegate{
    
    
    let moviesViewController = MoviesViewController()
    let favoritesViewController = FavoritesViewController()

    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        
        setTabs()
        setColor()
        
    }
    
    
    
    
    func setTabs(){
        
        
        
        moviesViewController.title = "Movies"
        moviesViewController.tabBarItem.image = #imageLiteral(resourceName: "list_icon")
        // moviesViewController.tabBarItem.selectedImage = UIImage(named: "list_icon")
        
        favoritesViewController.title = "Favorites"
        favoritesViewController.tabBarItem.image = #imageLiteral(resourceName: "favorite_gray_icon")
        // favoritesViewController.tabBarItem.selectedImage = UIImage(named: "favorite_emply_icon")
        
        
        let controllers = [moviesViewController, favoritesViewController]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        
        
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
                
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
           
            print(favoriteMovies)
            
            moviesViewController.loadFavorites()
            moviesViewController.screen.movieCollectionView.reloadData()
            
        }else if tabBarIndex == 1{
            favoritesViewController.filterData()
            favoritesViewController.screen.favoritesTableView.reloadData()
            
        }
        
        
    }
    
    func setColor(){
        
        UINavigationBar.appearance().barTintColor = UIColor(red:0.96, green:0.80, blue:0.39, alpha:1.00)
        UINavigationBar.appearance().tintColor = UIColor(red:0.18, green:0.19, blue:0.27, alpha:1.00)
        //  UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        UITabBar.appearance().barTintColor = UIColor(red:0.96, green:0.80, blue:0.39, alpha:1.00)
        UITabBar.appearance().tintColor = UIColor(red:0.18, green:0.19, blue:0.27, alpha:1.00)
        
    }
    
    
}

