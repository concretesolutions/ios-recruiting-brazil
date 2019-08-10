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
    private let coreData:CoreData = CoreData()
    private let entityName:String = "Favorites"
    
    private func mapperObject(favorites:FavoritesDetailsData, toSave:Bool) -> NSManagedObject {
        
        let entity:NSEntityDescription = NSEntityDescription.entity(forEntityName: entityName, in: self.coreData.managedObjectContext)!
        //TODO: TROCAR PARA BUSCAR O OBJETO CASO NÃO FOR PARA SALVAR
        let objectToSave: NSManagedObject?
        if toSave {
            objectToSave = NSManagedObject(entity: entity, insertInto: self.coreData.managedObjectContext)
            
            objectToSave!.setValue(favorites.id, forKey: "id")
            objectToSave!.setValue(favorites.name, forKey: "name")
            objectToSave!.setValue(favorites.posterPath, forKey: "posterPath")
            objectToSave!.setValue(favorites.overView, forKey: "overview")
            objectToSave!.setValue(favorites.year, forKey: "year")
        }
        else {
            let predicate:NSPredicate = NSPredicate(format: "id = %d", favorites.id)
            let resultFetch = self.coreData.executeFetchRequest(entityName: entityName, predicate: predicate)
            objectToSave = (resultFetch as! [NSManagedObject]).first!
        }
        
       
        return objectToSave!
    }
    
    func save(favorites:FavoritesDetailsData) -> Bool {
        
        let objectToSave = self.mapperObject(favorites: favorites, toSave: true)
        self.coreData.saveContext()
        print(objectToSave.objectID)
        return true
    }
    
    func getFavorite(id:Int) -> FavoritesDetailsData {
        let predicate:NSPredicate = NSPredicate(format: "id = %d", id)
        let resultFetch = self.coreData.executeFetchRequest(entityName: entityName, predicate: predicate)
        let resultObject:NSManagedObject = (resultFetch as! [NSManagedObject]).first!
        let favorite:FavoritesDetailsData = FavoritesDetailsData(id: resultObject.value(forKey: "id") as! Int, name: resultObject.value(forKey: "name") as! String, posterPath: resultObject.value(forKey: "posterPath") as! String, year: resultObject.value(forKey: "year") as! Int, overView: resultObject.value(forKey: "overview") as! String)
        return favorite
    }
    
    func loadFavorites() -> [FavoritesDetailsData]{
        
        let resultFetch = self.coreData.executeFetchRequest(entityName: entityName)
        let resultListObject:[NSManagedObject] = resultFetch as! [NSManagedObject]
        let favoritesList:[FavoritesDetailsData] = resultListObject.map { object in
             return FavoritesDetailsData(id: object.value(forKey: "id") as! Int, name: object.value(forKey: "name") as! String, posterPath: object.value(forKey: "posterPath") as! String, year: object.value(forKey: "year") as! Int, overView: object.value(forKey: "overview") as! String)
        }
        return favoritesList
    }
    
    func remove(favorites:FavoritesDetailsData) {
        let objectToDelete =  self.mapperObject(favorites: favorites, toSave: false)
        self.coreData.remove(objectToDelete: objectToDelete)
    }
}
