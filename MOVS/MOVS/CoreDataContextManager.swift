//
//  CoreDataContextManager.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 18/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataContextManager: NSObject{
    // MARK: - Core Data stack
    
    static let shared = CoreDataContextManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MOVS")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                print("Error trying to create core data persistent container in: \(CoreDataContextManager.self)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    public func saveContext () {
        let context = CoreDataContextManager.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error trying to save core data context in: \(CoreDataContextManager.self)")
            }
        }
    }
    
}
