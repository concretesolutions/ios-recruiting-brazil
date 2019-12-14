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
    internal let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Movs")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Publishers
    
    @Published var favorites: Set<CDFavoriteMovie> = Set()
    
    // MARK: - Initializers and Deinitializers
    
    init() {
        self.managedContext = self.persistentContainer.viewContext
        
        let fetchAllFavorites = NSFetchRequest<CDFavoriteMovie>(entityName: "CDFavoriteMovie")
        self.favorites = self.fetch(request: fetchAllFavorites)
    }
    
    // MARK: - Management
    
    private func createEntity(named name: String) -> NSEntityDescription {
        guard let entity = NSEntityDescription.entity(forEntityName: name, in: self.managedContext) else {
            fatalError("Failed to retrieve CDFavoriteMovie in current context")
        }
        return entity
    }
    
    private func fetch<Entity: NSFetchRequestResult>(request: NSFetchRequest<Entity>) -> Set<Entity> {
        do {
            let fetchResults = try self.managedContext.fetch(request)
            return Set(fetchResults)
        } catch {
            return Set()
        }
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
    
    // MARK: - Update methods
    
    func isFavorited(movieID: Int) -> Bool {
        let result = self.favorites.map({ $0.id }).contains(Int64(movieID))
        return result
    }
    
    func addFavorite(movie: Movie) {
        guard !self.isFavorited(movieID: movie.id) else {
            return
        }
        
        let entity = self.createEntity(named: "CDFavoriteMovie")
        let favoriteMovie = self.createFavoriteMovie(movie: movie, description: entity)
        self.favorites.insert(favoriteMovie)
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
