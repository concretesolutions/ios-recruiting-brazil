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
        let tabBarController = UITabBarController()
        
        // First Tab Bar View Controller
        let popularMoviesVC = PopularMoviesViewController()
        popularMoviesVC.title = "Popular Movies"
        popularMoviesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent , tag: 0)
        
        // Second Tab Bar View Controller
        let favouriteMoviesVC = FavouriteMoviesViewController()
        favouriteMoviesVC.title = "Favourite Movies"
        favouriteMoviesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        // Adding navigation controller
        let controllers = [popularMoviesVC, favouriteMoviesVC]
        tabBarController.viewControllers = controllers.map({
            UINavigationController(rootViewController: $0)
        })
        
        window.rootViewController = tabBarController
        self.window = window
        
        window.makeKeyAndVisible()
        return true
    }
    
}
