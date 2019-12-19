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
    
    @Published var favorites: Set<CDFavoriteMovie> = Set()
    
    // MARK: - Initializers and Deinitializers
    
    init(container: NSPersistentContainer) {
        self.managedContext = container.viewContext
        
        let fetchAllFavorites = NSFetchRequest<CDFavoriteMovie>(entityName: "CDFavoriteMovie")
        do {
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
    
    // MARK: - Instance Management
    
    func isFavorited(movieID: Int) -> Bool {
        let result = self.favorites.map({ $0.id }).contains(Int64(movieID))
        return result
    }
    
    func addFavorite(movie: Movie) {
        guard !self.isFavorited(movieID: movie.id) else {
            return
        }
        
        do {
            let entity = try self.createEntity(named: "CDFavoriteMovie")
            let favoriteMovie = self.createFavoriteMovie(movie: movie, description: entity)
            self.favorites.insert(favoriteMovie)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeFavorite(movieID: Int64) {
        let objects = self.favorites.filter({ $0.id == movieID })
        for object in objects {
            self.managedContext.delete(object)
            self.favorites.remove(object)
        }
    }
}

extension StorageManager: CoreDataFactory {
    func createFavoriteMovie(movie: Movie, description: NSEntityDescription) -> CDFavoriteMovie {
        let instance = CDFavoriteMovie(entity: description, insertInto: self.managedContext)
        instance.backdropPath = movie.backdropPath
        instance.genreIDs = NSSet(array: movie.genres.map({ $0.id }))
        instance.id = Int64(movie.id)
        instance.posterPath = movie.posterPath
        instance.releaseDate = movie.releaseDate
        instance.summary = movie.summary
        instance.title = movie.title
        
        return instance
    }
}
