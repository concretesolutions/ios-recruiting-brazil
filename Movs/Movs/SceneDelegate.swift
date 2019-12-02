//
//  SceneDelegate.swift
//  Movs
//
//  Created by Lucca Ferreira on 01/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    let tabBarController: UITabBarController = {
        let tabBarController = UITabBarController()
        let moviesViewController = MoviesViewController()
        let favoritesViewController = FavoritesViewController()
        tabBarController.viewControllers = [moviesViewController, favoritesViewController]
        return tabBarController
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        self.window = window

        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}
