//
//  CoreDataStack.swift
//  Concrete Movies
//
//  Created by Lucas Daniel on 27/08/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class CoreDataStack {
    
    static let shared = CoreDataStack()
    var errorHandler: (Error) -> Void = {_ in }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Concrete_Movies")
        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
            if let error = error {
                NSLog("CoreData error \(error), \(error._userInfo)")
                self?.errorHandler(error)
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    func configureContexts() {
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func saveContext() {
        if self.persistentContainer.viewContext.hasChanges {
            do {
                try self.persistentContainer.viewContext.save()
            } catch {
                NSLog("Error occured while saving persistent store: \(error), \(error._userInfo)")
                self.errorHandler(error)
            }
        }
    }
    
    func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.viewContext.perform {
            block(self.viewContext)
        }
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask(block)
    }
        
}
