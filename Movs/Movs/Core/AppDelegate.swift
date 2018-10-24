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
    let appCoordinator = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let coordinator = MoviesGridCoordinator()
//        let initial = MoviesGridViewController()
//        initial.presenter = MoviesGridPresenter(view: initial, coordinator: coordinator)
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = MovsTabBarController()
//        self.window?.makeKeyAndVisible()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator.onCoordinatorStarted = { [unowned self] vc in
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        self.appCoordinator.start()
        
        return true
    }
}

