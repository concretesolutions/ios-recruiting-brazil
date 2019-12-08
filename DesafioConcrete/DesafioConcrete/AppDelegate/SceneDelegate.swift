//
//  SceneDelegate.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 30/11/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var moviesNavController:UINavigationController?
    var favNavController:UINavigationController?
    var tabBarController:UITabBarController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let movieVC = ViewController()
        movieVC.title = "Movies"
        movieVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named:"list_icon"), tag: 0)
        
        let favoriteVC = FavoritesViewController()
        favoriteVC.title = "Favorites"
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named:"favorite_empty_icon"), tag: 0)
        
        moviesNavController = UINavigationController()
        moviesNavController!.title = "Movies"
        moviesNavController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        moviesNavController?.navigationBar.barTintColor = .customYellow
        moviesNavController?.navigationBar.backgroundColor = .customYellow
        moviesNavController?.navigationBar.tintColor = .black
        moviesNavController?.viewControllers = [movieVC]
        
        favNavController = UINavigationController()
        favNavController!.title = "Favorites"
        favNavController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        favNavController?.navigationBar.barTintColor = .customYellow
        favNavController?.navigationBar.backgroundColor = .customYellow
        favNavController?.navigationBar.tintColor = .black
        favNavController?.viewControllers = [favoriteVC]
        
        tabBarController = UITabBarController()
        tabBarController?.tabBar.barTintColor = .customYellow
        tabBarController?.tabBar.tintColor = .black
        tabBarController?.viewControllers = [moviesNavController, favNavController] as? [UIViewController]
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
    }

}

