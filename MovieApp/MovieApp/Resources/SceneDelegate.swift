//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let tabBar = UITabBarController()
        tabBar.view.tintColor = .orange
        let movieViewController = HomeViewController()

       movieViewController.tabBarItem = UITabBarItem(title: "Movies", image: #imageLiteral(resourceName: "icons8-a_home"), selectedImage: #imageLiteral(resourceName: "icons8-home_filled"))
        movieViewController.tabBarItem.tag = 0
    
        let favoritesViewControllers = FavoriteViewController()
        favoritesViewControllers.tabBarItem = UITabBarItem(title: "Favorites", image:#imageLiteral(resourceName: "icons8-film_reel"), selectedImage: #imageLiteral(resourceName: "icons8-film_reel_filled"))
        favoritesViewControllers.tabBarItem.tag = 1
        
        let viewControllerList = [ movieViewController, favoritesViewControllers ]
        tabBar.viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0)}
        
    
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    
}
