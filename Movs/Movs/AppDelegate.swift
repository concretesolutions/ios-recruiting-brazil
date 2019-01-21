//
//  AppDelegate.swift
//  Movs
//
//  Created by Franclin Cabral on 1/17/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        var navigationBarAppearence = UINavigationBar.appearance()
        navigationBarAppearence.tintColor = UIColor.white
        navigationBarAppearence.barTintColor = UIColor.rgb(red: 247, green: 206, blue: 91)
        navigationBarAppearence.isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.rgb(red: 247, green: 206, blue: 91)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        configure()
        ManagerCenter.shared.router.window = window
        
        ManagerCenter.shared.router.window = self.window
        ManagerCenter.shared.router.changeRoot(to: .splash)
        return true
    }
    
    func configure() {
        let factoryBuilder = FactoryBuilder { (fb) in
            fb.networking = Networking()
            fb.dataStore = DataStore()
        }
        
        let factory = Factory(builder: factoryBuilder)
        let vmFactory: ViewModelFactory = ViewModelFactory(factory: factory)
        let router = Router(viewModelFactory: vmFactory)
        ManagerCenter.configure(config: ManagerConfiguration(factory: factory, router: router))
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

