//
//  AppDelegate.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // fetch genres to cache
        TMDBMoyaGateway().fetchGenres { (result) in
            if case let .success(genres) = result {
                Genre.genres = genres
            } else {/*do nothing*/}
        }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MainTabBarBuilder.build()
        
        self.window = window
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

