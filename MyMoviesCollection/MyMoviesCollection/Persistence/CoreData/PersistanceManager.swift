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
    
    public func fetchFavoritesList() throws -> [FavoriteMovie] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        return try (managedObjectContext.fetch(request) as? [FavoriteMovie] ?? [])
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
    
    public func deleteFavorite(id: Int32) throws {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        let predicate = NSPredicate(format: "id == %d", id)
        request.predicate = predicate
        
        try managedObjectContext.fetch(request)
         
    }
}
