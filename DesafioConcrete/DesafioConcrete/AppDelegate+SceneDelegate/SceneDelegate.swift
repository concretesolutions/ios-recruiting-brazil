//
//  SceneDelegate.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 23/11/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let tabBar = UITabBarController()
        let moviesController = MoviesRouter.createModule()
        let favoritesController = FavoritesRouter.createModule()
        let moviesNavigation = UINavigationController(rootViewController: moviesController)
        let favoritesNavigation = UINavigationController(rootViewController: favoritesController)
        moviesNavigation.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "list_icon")?.withRenderingMode(.alwaysOriginal))
        favoritesNavigation.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite_empty_icon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "favorite_empty_icon")?.withRenderingMode(.alwaysOriginal))
        tabBar.viewControllers = [moviesNavigation, favoritesNavigation]
        
        ApperanceHelper.customizeNavigationBar()
        ApperanceHelper.customizeTabBar()
        
        window.rootViewController = tabBar
        self.window = window
        window.makeKeyAndVisible()
    }
}

