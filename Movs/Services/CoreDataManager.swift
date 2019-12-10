//
//  CoreDataManager.swift
//  Movs
//
//  Created by Gabriel D'Luca on 07/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    // MARK: - Properties
    
    private let managedContext: NSManagedObjectContext
    @Published var favorites: Set<CDFavoriteMovie> = Set()
    
    // MARK: - Initializers and Deinitializers
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Failed to retrieve AppDelegate")
        }
        
        self.managedContext = appDelegate.persistentContainer.viewContext
        self.favorites = self.fetch(request: NSFetchRequest<CDFavoriteMovie>(entityName: "CDFavoriteMovie"))
    }
    
    // MARK: - Helpers
    
    private func fetch<Entity: NSFetchRequestResult>(request: NSFetchRequest<Entity>) -> Set<Entity> {
        do {
            let fetchResults = try self.managedContext.fetch(request)
            return Set(fetchResults)
        } catch {
            return Set()
        }
    }
    
    // MARK: - Update methods
    
    func isFavorited(movieID: Int) -> Bool {
        let result = self.favorites.map({ $0.movieID }).contains(Int64(movieID))
        return result
    }
    
    func addFavorite(movieID: Int) {
        guard !self.isFavorited(movieID: movieID) else {
            return
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "CDFavoriteMovie", in: self.managedContext) else {
            fatalError("Failed to retrieve CDFavoriteMovie in current context")
        }

        let newInstance = CDFavoriteMovie(entity: entity, insertInto: self.managedContext)
        newInstance.movieID = Int64(movieID)
        self.favorites.insert(newInstance)
    }
    
    func removeFavorite(movieID: Int) {
        let objects = self.favorites.filter({ $0.movieID == Int64(movieID) })
        for object in objects {
            self.managedContext.delete(object)
            self.favorites.remove(object)
        }
    }
}
