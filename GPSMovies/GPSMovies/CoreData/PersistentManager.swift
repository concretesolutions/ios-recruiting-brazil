//
//  MovieDataBase.swift
//  GPSMovies
//
//  Created by Gilson Santos on 04/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import Foundation
import CoreData

class PersistentManager {
    
    static let shared = PersistentManager()
    private init(){}
    
    // MARK: - Core Data
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GPSMovies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
}

extension PersistentManager {
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

