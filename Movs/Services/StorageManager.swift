//
//  StorageManager.swift
//  Movs
//
//  Created by Gabriel D'Luca on 07/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import CoreData

class StorageManager {
    
    // MARK: - Properties
    
    internal let managedContext: NSManagedObjectContext
    
    // MARK: - Enums
    
    enum CreationError: Error {
        case runtimeError(String)
    }
    
    // MARK: - Publishers
    
    @Published var genres: Set<CDGenre> = Set()
    @Published var favorites: Set<CDFavoriteMovie> = Set()
    
    // MARK: - Initializers and Deinitializers
    
    init(container: NSPersistentContainer) {
        self.managedContext = container.viewContext
        
        let fetchAllGenres = NSFetchRequest<CDGenre>(entityName: "CDGenre")
        let fetchAllFavorites = NSFetchRequest<CDFavoriteMovie>(entityName: "CDFavoriteMovie")
        do {
            self.genres = try self.fetch(request: fetchAllGenres)
            self.favorites = try self.fetch(request: fetchAllFavorites)
        } catch {
            fatalError("Failed to fetch all instances of CDFavoriteMovie.")
        }
    }
    
    // MARK: - Container Management
    
    func createEntity(named name: String) throws -> NSEntityDescription {
        guard let entity = NSEntityDescription.entity(forEntityName: name, in: self.managedContext) else {
            throw CreationError.runtimeError("Failed to retrieve entity \(name) in current context")
        }
        return entity
    }
    
    func fetch<Entity: NSFetchRequestResult>(request: NSFetchRequest<Entity>) throws -> Set<Entity> {
        let fetchResults = try self.managedContext.fetch(request)
        return Set(fetchResults)
    }
    
    func save() {
        if self.managedContext.hasChanges {
            do {
                try self.managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
