//
//  AppDelegate.swift
//  movs
//
//  Created by Renan Oliveira on 16/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit
import IQKeyboardManager
import SVProgressHUD
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    fileprivate var tabBarController: UITabBarController!
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.pushInitialController()
        self.setupApplication()
        self.setupKeyboard()
        self.setupProgress()
        self.setupDatabase()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) {}
    
    fileprivate func setupDatabase() {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        print(realm.configuration.fileURL)
    }
    
    fileprivate func setupKeyboard() {
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        IQKeyboardManager.shared().keyboardDistanceFromTextField = 10
    }
    
    fileprivate func setupApplication() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font: UIFont.bold(size: 17), NSAttributedStringKey.foregroundColor: UIColor.black]
        UITabBar.appearance().backgroundColor = UIColor.mvYellow
        UITabBar.appearance().tintColor = UIColor.black
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font : UIFont.regular(size: 12) as Any], for: .normal)
    }
    
    fileprivate func setupProgress() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setForegroundColor(UIColor.mvYellow)
    }
    
    fileprivate func pushInitialController() {
        self.window = UIWindow()
        self.tabBarController = UITabBarController()
        self.tabBarController.delegate = self
        self.tabBarController.tabBar.isTranslucent = false
        self.tabBarController.tabBar.barTintColor = UIColor.mvYellow

        var viewControllers: [UIViewController] = []
        viewControllers.append(AppDelegateRouter.addHomeFlow())
        viewControllers.append(AppDelegateRouter.addFavoriteFlow())
        tabBarController.viewControllers = viewControllers
        
        self.window?.rootViewController = tabBarController
        self.window?.frame = UIScreen.main.bounds
        self.window?.makeKeyAndVisible()
    }
}

extension AppDelegate: UITabBarControllerDelegate {}


