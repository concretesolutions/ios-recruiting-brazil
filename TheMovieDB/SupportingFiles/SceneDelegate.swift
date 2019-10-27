//
//  SceneDelegate.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 24/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        configTheme()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window!.rootViewController = SplashViewController()
        window!.makeKeyAndVisible()
    }
    
    private func configTheme() {
        UINavigationBar.appearance().tintColor = Colors.primary
        UINavigationBar.appearance().barTintColor = Colors.accent
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : Colors.primary]
    }
}
