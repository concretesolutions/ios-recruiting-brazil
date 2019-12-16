//
//  AppDelegate.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)

        // Set the the main VC
        let popularNavigationController = NavigationController(rootViewController: Factory.getViewController(using: PopularsPresenter()))
        popularNavigationController.tabBarItem = UITabBarItem(title: "Popular", image: #imageLiteral(resourceName: "star"), tag: 0)

        let favoritesNavigationController = NavigationController(rootViewController: Factory.getViewController(using: FavoritesPresenter()))
        favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "favoriteFull"), tag: 1)
        
        let tabBarController = TabBarController()
        tabBarController.setViewControllers([popularNavigationController, favoritesNavigationController], animated: true)
        
        
        window?.rootViewController = tabBarController

        // Present the window
        window?.makeKeyAndVisible()
        
        return true
    }
}

