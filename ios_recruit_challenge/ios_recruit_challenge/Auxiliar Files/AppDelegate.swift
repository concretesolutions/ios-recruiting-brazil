//
//  AppDelegate.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 08/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = setupTabBar(item0Title: "Movies", item1Title: "Favorites")
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ios_recruit_challenge")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
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
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func setupTabBar(item0Title:String,item1Title:String) -> UITabBarController{
        let nc0 = setupNavigationBar(title: item0Title, controller: MoviesController())
        let nc1 = setupNavigationBar(title: item1Title, controller: FavoritesController())
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nc0,nc1]
        tabBarController.selectedIndex = 0
        tabBarController.tabBar.backgroundColor = UIColor(red: 246/255, green: 205/255, blue: 100/255, alpha: 1)
        tabBarController.tabBar.tintColor = UIColor(red: 134/255, green: 8/255, blue: 63/255, alpha: 1)
        tabBarController.tabBar.items![0].title = item0Title
        tabBarController.tabBar.items![0].image = UIImage(named: "itens")?.withRenderingMode(.alwaysOriginal)
        tabBarController.tabBar.items![0].selectedImage = UIImage(named: "itensSelected")?.withRenderingMode(.alwaysOriginal)
        tabBarController.tabBar.items![1].title = item1Title
        tabBarController.tabBar.items![1].image = UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal)
        tabBarController.tabBar.items![1].selectedImage = UIImage(named: "heartSelected")?.withRenderingMode(.alwaysOriginal)
        return tabBarController
    }
    
    func setupNavigationBar(title:String, controller:UIViewController)->UINavigationController{
        controller.navigationItem.title = title
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationBar.barTintColor = UIColor(red: 246/255, green: 205/255, blue: 100/255, alpha: 1)
        return navigationController
    }

}

