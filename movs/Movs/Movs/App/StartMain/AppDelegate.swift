//
//  AppDelegate.swift
//  Movs
//
//  Created by Marcos Felipe Souza on 28/02/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
     
    var window: UIWindow?
    var appCoordinator: CoordinatorType?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.appCoordinator = AppCoordinator(window: self.window)
        StartMain.shared.start(appCoordinator: self.appCoordinator!)
        return true
    }
}

