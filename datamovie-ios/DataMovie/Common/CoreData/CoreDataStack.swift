//
//  CoreDataStack.swift
//  DataMovie
//
//  Created by Andre Souza on 27/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

import Foundation
import CoreData

//MARK: - Core Data stack
class CoreDataStack: NSObject {
    
    static let sharedInstance = CoreDataStack()
    static let containerName = "DatamovieDB"
    
    private override init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataStack.containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
}

// MARK: - Core Data Saving support

extension CoreDataStack {
    
    func saveContext() {
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
    
}
