//
//  AppDelegate.swift
//  Movs
//
//  Created by Ricardo Rachaus on 23/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let controller = ViewController()
        window.rootViewController = controller
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }

}

