//
//  AppDelegate.swift
//  Movs
//
//  Created by Gabriel Reynoso on 20/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let coordinator = MoviesGridCoordinator()
        let initial = MoviesGridViewController()
        initial.presenter = MoviesGridPresenter(view: initial, coordinator: coordinator)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: initial)
        self.window?.makeKeyAndVisible()
        return true
    }
}

