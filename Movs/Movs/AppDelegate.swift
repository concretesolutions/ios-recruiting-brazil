//
//  AppDelegate.swift
//  Movs
//
//  Created by Julio Brazil on 21/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let moviesView: MoviesCollectionViewController = {
            let vc = MoviesCollectionViewController()
            vc.title = "Movies"
            vc.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon"), selectedImage: UIImage(named: "list_icon"))
            return vc
        }()
        
        let navigation1: UINavigationController = {
            let vc = UINavigationController(rootViewController: moviesView)
            vc.navigationBar.barTintColor = .MovYellow
            vc.navigationBar.tintColor = UIColor.black
            vc.navigationBar.isTranslucent = false
            return vc
        }()
        
        let favorites: FavoritesTableViewController = {
            let vc = FavoritesTableViewController()
            vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite_empty_icon"), selectedImage: UIImage(named: "favorite_empty_icon"))
            vc.title = "Favorites"
            return vc
        }()
        
        let navigation2: UINavigationController = {
            let vc = UINavigationController(rootViewController: favorites)
            vc.navigationBar.barTintColor = .MovYellow
            vc.navigationBar.tintColor = UIColor.black
            vc.navigationBar.isTranslucent = false
            return vc
        }()
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigation1, navigation2]
        tabBarController.tabBar.barTintColor = .MovYellow
        tabBarController.tabBar.isTranslucent = false
        
        window.rootViewController = tabBarController
        
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Movs")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

