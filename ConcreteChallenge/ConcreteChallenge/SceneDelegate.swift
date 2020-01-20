//
//  SceneDelegate.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let serviceLayer = ServiceLayer()
        let movieCollection = MovieColletion(serviceLayer: serviceLayer)
        let genreCollection = GenreCollection(serviceLayer: serviceLayer)
        let tabBarInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        
        let moviesViewController = MoviesViewController(movieCollection: movieCollection, genreCollection: genreCollection)
        let moviesTabBarItem = UITabBarItem(title: nil, image: UIImage(named: Images.listHollow), selectedImage: UIImage(named: Images.listFilled))
        
        moviesViewController.title = "Movies"
        moviesViewController.tabBarItem = moviesTabBarItem
        moviesTabBarItem.imageInsets = tabBarInsets
        
        let favoritesViewController = FavoritesViewController(movieCollection: movieCollection, genreCollection: genreCollection)
        let favoriteTabBarItem = UITabBarItem(title: nil, image: UIImage(named: Images.heartHollow), selectedImage: UIImage(named: Images.heartFilled))
        
        favoritesViewController.title = "Favorites"
        favoritesViewController.tabBarItem = favoriteTabBarItem
        favoriteTabBarItem.imageInsets = tabBarInsets
        
        let controllers = [moviesViewController, favoritesViewController]
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        
        window.rootViewController = tabBarController
        
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

