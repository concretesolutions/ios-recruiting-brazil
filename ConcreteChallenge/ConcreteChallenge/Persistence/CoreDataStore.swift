//
//  CoreDataStore.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 16/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStore {
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ConcreteChallenge")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    static func delete(_ object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }

    static func fetch<T>(_ request: NSFetchRequest<T>) -> [T] {
        do {
            let list = try persistentContainer.viewContext.fetch(request)
            return list
        } catch {
            print(error)
            return [T]()
        }
    }

    static func findFirst<T>(_ request: NSFetchRequest<T>) -> T? {
        return fetch(request).first
    }

    static func saveContext () {
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
