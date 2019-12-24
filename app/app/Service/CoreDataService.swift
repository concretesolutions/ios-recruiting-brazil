//
//  CoreDataService.swift
//  app
//
//  Created by rfl3 on 23/12/19.
//  Copyright © 2019 Renan Freitas. All rights reserved.
//

import Foundation
import CoreData

class CoreDataService {
    
    public static var shared = CoreDataService()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var persistentContainer: NSPersistentContainer
    
    init() {
        let container: NSPersistentContainer = {
            /*
             The persistent container for the application. This implementation
             creates and returns a container, having loaded the store for the
             application to it. This property is optional since there are legitimate
             error conditions that could cause the creation of the store to fail.
             */
            let container = NSPersistentContainer(name: "app")
            
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
                } else {
                    print(storeDescription)
                }
            })
            
            return container
        }()
        
        self.persistentContainer = container
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext() throws {
        if self.context.hasChanges {
            do {
                try self.context.save()
                
            } catch let error as NSError {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                throw error
            }
        }
    }
    
    // MARK: - Insert Methods
    
    /// Insert a new movie to the favorite list
    /// - Parameter id: movie id
    func insertFavorite(_ id: Int) throws -> Int {
        
        let favorite = Favorite(context: self.context)
        favorite.id = Int64(id)
        
        do {
            try self.saveContext()
            return id
        } catch let error {
            throw error
        }
        
    }
    
    // MARK: - Fetch Methods
    
    /// Fetch all favorite movies, returning a list of their ids
    func fetchAllFavorite() throws -> [Int] {
        
        let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
        
        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites.map({ Int($0.id) })
        } catch let error {
            throw error
        }
        
    }
    
    /// fetch a movie from the favorite list
    /// - Parameter id: movie id
    func fetchFavorite(_ id: Int) throws -> NSManagedObject? {
        
        let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        
        do {
            let favorites = try context.fetch(fetchRequest)
            if let favorite = favorites.first {
                return favorite
            } else {
                return nil
            }
        } catch let error {
            throw error
        }
        
    }
    
    /// Check if a given movie is in the favorite list
    /// - Parameter id: movie id
    func isFavorite(_ id: Int) throws -> Bool {
        
        let fetchRequest = NSFetchRequest<Favorite>(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        
        do {
            let favorites = try context.fetch(fetchRequest)
            return !favorites.isEmpty
        } catch let error {
            throw error
        }
        
    }
    
    // MARK: - Delete
    
    /// deletes a given favorite movie
    /// - Parameter id: movie id
    func delete(_ id: Int) throws {
        
        do {
            if let favorite = try self.fetchFavorite(id) {
                self.context.delete(favorite)
                try self.saveContext()
            }
        } catch let error {
            throw error
        }

    }
    
}
