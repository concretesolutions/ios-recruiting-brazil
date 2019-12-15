//
//  AppDelegate.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 12/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    typealias LaunchOptions = UIApplication.LaunchOptionsKey
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [LaunchOptions: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let moviesGrid = MoviesGridController()
        moviesGrid.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon"), tag: 0)
        
        let favories = UIViewController()
        favories.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorite_empty_icon"), tag: 1)
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = .yellow
        tabBarController.setViewControllers([UINavigationController(rootViewController: moviesGrid), favories], animated: true)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        return true
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ios_recruiting_brazil")
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

