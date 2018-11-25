//
//  FavoriteDAO.swift
//  Movs
//
//  Created by Adann Simões on 17/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import Foundation
import CoreData

class FavoriteDAO {
    /// Method responsible for creating a favorite into database
    /// - parameters:
    ///     - objectToBeSaved: favorite to be saved on database
    /// - throws: if an error occurs during saving an object into database (Errors.DatabaseFailure)
    static func create(_ objectToBeSaved: Favorite) throws {
        do {
            // add object to be saved to the context
            CoreDataManager.sharedInstance.persistentContainer.viewContext.insert(objectToBeSaved)
            
            // persist changes at the context
            try CoreDataManager.sharedInstance.persistentContainer.viewContext.save()
            
        } catch {
            throw Errors.DatabaseFailure
        }
    }
    
    /// Method responsible for gettings all favorite from database
    /// - returns: a list of favorite from database
    /// - throws: if an error occurs during getting an object from database (Errors.DatabaseFailure)
    static func findAll() throws -> [Favorite] {
        // list of favorite to be returned
        var favorite: [Favorite]
        do {
            
            let request = NSFetchRequest<Favorite>(entityName: "Favorite")
            // perform search
            favorite = try CoreDataManager.sharedInstance.persistentContainer.viewContext.fetch(request)
            
        } catch {
            throw Errors.DatabaseFailure
        }
        
        return favorite
    }
    
    
    /// Method responsible for delete one object from database
    static func delete(_ objToBeDeleted: NSManagedObject) throws {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        //fetchRequest.predicate = NSPredicate(format: "id = %@", "\(Id)")
        do {
            //swiftlint:disable line_length
            guard (try CoreDataManager.sharedInstance.persistentContainer.viewContext.fetch(fetchRequest) as? [NSManagedObject]) != nil else { return }
            //swiftlint:enable line_length
                CoreDataManager.sharedInstance.persistentContainer.viewContext.delete(objToBeDeleted)
                do {
                    try CoreDataManager.sharedInstance.persistentContainer.viewContext.save()
                } catch let error as Error? {
                    if let err = error {
                        print("ooops \(err.localizedDescription)")
                    }
                }

        } catch _ {
            print("Could not delete")
            
        }
        
    }
    
    /// Method responsible for updating a favorite into database
    /// - parameters:
    ///     - objectToBeUpdated: favorite to be updated on database
    /// - throws: if an error occurs during updating an object into database (Errors.DatabaseFailure)
    static func update(_ objectToBeUpdated: Favorite) throws {
        do {
            // persist changes at the context
            try CoreDataManager.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            
            print(error.localizedDescription)
            throw Errors.DatabaseFailure
            
        }
    }
    
}
