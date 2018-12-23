//
//  AppDelegate.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 14/11/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .black
        navigationBarAppearace.barTintColor = Design.Colors.clearYellow
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.barTintColor = Design.Colors.clearYellow
        
        let moviesGrid = MoviesGridViewController()
        moviesGrid.title = "Movies"
        moviesGrid.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon"), tag: 0)
        
        let favoriteMovies = FavoriteMoviesTableViewController()
        favoriteMovies.title = "Movies"
        favoriteMovies.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite_empty_icon"), tag: 1)
        
        let controllers = [moviesGrid, favoriteMovies]
        tabBarController.viewControllers = controllers.map({
            UINavigationController(rootViewController: $0)
        })
        
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

}
