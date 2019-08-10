//
//  FavoritesRepository.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 10/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
import CoreData

class FavoritesRepository {
    //MARK: Properties
    let coreData:CoreData = CoreData()
    let entityName:String = "Favorites"
    
    func save(favorites:FavoritesDetailsData) -> Bool {
        
       let entity:NSEntityDescription = NSEntityDescription.entity(forEntityName: entityName, in: self.coreData.managedObjectContext)!
        let objectToSave:NSManagedObject = NSManagedObject(entity: entity, insertInto: self.coreData.managedObjectContext)
        objectToSave.setValue(favorites.id, forKey: "id")
        objectToSave.setValue(favorites.name, forKey: "name")
        objectToSave.setValue(favorites.posterPath, forKey: "posterPath")
        objectToSave.setValue(favorites.overView, forKey: "overview")
        objectToSave.setValue(favorites.year, forKey: "year")
        self.coreData.saveContext()
        
        return true
    }
    
    func loadFavorites() -> [FavoritesDetailsData]{
        
        let resultFetch = self.coreData.executeFetchRequest(entityName: entityName)
        let resultListObject:[NSManagedObject] = resultFetch as! [NSManagedObject]
        let favoritesList:[FavoritesDetailsData] = resultListObject.map { object in
             return FavoritesDetailsData(id: object.value(forKey: "id") as! Int, name: object.value(forKey: "name") as! String, posterPath: object.value(forKey: "posterPath") as! String, year: object.value(forKey: "year") as! Int, overView: object.value(forKey: "overview") as! String)
        }
        return favoritesList
    }
}
