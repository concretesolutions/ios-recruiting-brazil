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
    
//    func fetchFavoritesList() throws -> [Movie] {
//      let request: NSFetchRequest<Movie> = FavoriteMovie.fetchRequest()
//      return try managedObjectContext.fetch(request)
//    }
}
