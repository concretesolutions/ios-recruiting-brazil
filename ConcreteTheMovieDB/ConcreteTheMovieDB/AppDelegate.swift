//
//  AppDelegate.swift
//  ConcreteTheMovieDB
//
//  Created by Guilherme Gatto on 12/11/18.
//  Copyright © 2018 Guilherme Gatto. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container  = NSPersistentContainer(name: "Favorite")
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                print(error.debugDescription)
            }
        })
        return container
    }()
    
    func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("error trying save context")
            }
        }
    }
    
}

