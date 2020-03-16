//
//  PersistanceManager.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 15/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import CoreData

class PersistanceManager {
    
    let managedObjectContext = PersistanceService.context
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
    
    public func fetchFavoritesList() throws -> [FavoriteMovie] {
        return try (managedObjectContext.fetch(fetchRequest) as? [FavoriteMovie] ?? [])
    }
    
    public func saveFavorite(movie: Movie) throws {
        let movieToSave = FavoriteMovie(context: managedObjectContext)
        movieToSave.title = movie.title
        movieToSave.id = movie.id ?? 0
        movieToSave.overview = movie.overview
        movieToSave.year = String(movie.releaseDate?.prefix(4) ?? "0000")
        movieToSave.posterUrl = movie.posterUrl
      
        try managedObjectContext.save()
    }
    
    public func deleteFavorite(id: Int32) -> Bool {
        var didDeleted = false
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        do {
            if let items = try managedObjectContext.fetch(fetchRequest) as? [FavoriteMovie] {
                for item in items {
                    managedObjectContext.delete(item)
                    didDeleted = true
                }
                return didDeleted
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    public func checkFavorite(id: Int32) throws -> [FavoriteMovie] {
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        return try (managedObjectContext.fetch(fetchRequest) as? [FavoriteMovie] ?? [])
    }
}
