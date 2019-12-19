//
//  AppDelegate.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 11/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        appCoordinator = AppCoordinator(tabBarController: UITabBarController())

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = appCoordinator?.rootViewController
        appCoordinator?.start()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        CoreDataStore.saveContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStore.saveContext()
    }

}
