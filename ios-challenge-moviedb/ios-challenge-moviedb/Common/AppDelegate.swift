//
//  AppDelegate.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 20/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        appCoordinator = AppCoordinator()
        appCoordinator?.start()
        
        return true
    }

}

