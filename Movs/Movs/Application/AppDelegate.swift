//
//  AppDelegate.swift
//  Movs
//
//  Created by Erick Lozano Borges on 11/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        // configure tabbar controller
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = Design.colors.dark
        tabBarController.tabBar.barTintColor = Design.colors.mainYellow
        
        // First Tab Bar View Controller
        let popularMoviesVC = PopularMoviesViewController()
        popularMoviesVC.title = "Popular Movies"
        popularMoviesVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named:"list_icon"), tag: 0)
        
        // Second Tab Bar View Controller
        let favoriteMoviesVC = FavoriteMoviesViewController()
        favoriteMoviesVC.title = "Favorite Movies"
        favoriteMoviesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named:"favorite_empty_icon"), tag: 1)
        
        // Adding navigation controller
        let controllers = [popularMoviesVC, favoriteMoviesVC]
        tabBarController.viewControllers = controllers.map({
            UINavigationController(rootViewController: $0)
        })
        
        // set root viewController
        window.rootViewController = tabBarController
        self.window = window
        
        window.makeKeyAndVisible()
        return true
    }
    
}
