//
//  AppDelegate.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        
        //Aqui seria a tabar
       // let controller = MoviesViewController()
       // window.rootViewController = controller
        
        
        let tabBarController = MovTabBarController()
        window.rootViewController = tabBarController
        
        self.window = window
        window.makeKeyAndVisible()
        
        
        return true
    }

   

}




