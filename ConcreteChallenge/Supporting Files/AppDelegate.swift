//
//  AppDelegate.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        print(UIScreen.main.bounds)

        // Set the the main VC
        window?.rootViewController = SplashVC(presenter: SplashPresenter())

        // Present the window
        window?.makeKeyAndVisible()
        
        return true
    }
}

