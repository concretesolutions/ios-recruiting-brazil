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
    /// Method responsible for saving a favorite into database
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
        var packList: [Favorite]
        
        do {
            // creating fetch request
            //let request:NSFetchRequest = NSFetchRequest<favorite>()
            
            let request = NSFetchRequest<Favorite>(entityName: "Favorite")
            
            // perform search
            packList = try CoreDataManager.sharedInstance.persistentContainer.viewContext.fetch(request)
            
        } catch {
            throw Errors.DatabaseFailure
        }
        
        return packList
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
