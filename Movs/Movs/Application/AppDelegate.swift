//
//  AppDelegate.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 01/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Variables

    var window: UIWindow?

    // MARK: - App life cycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.screenSetup()

        return true
    }

    // MARK: - Screnn setup

    private func screenSetup() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MovsViewController()
        self.window?.makeKeyAndVisible()
    }
}
