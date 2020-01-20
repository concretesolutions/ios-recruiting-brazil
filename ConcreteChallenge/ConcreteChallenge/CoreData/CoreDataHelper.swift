//
//  CoreDataHelper.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 15/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataHelperProtocol {
    func newFavoriteMovie() -> FavoriteMovie
    func retrieveFavoriteMovies() -> [FavoriteMovie]
    func favoriteMovie(for id: Int) -> FavoriteMovie?
    func save()
    func delete(favoriteMovie: FavoriteMovie)
}

class CoreDataHelper: CoreDataHelperProtocol {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ConcreteChallenge")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    func newFavoriteMovie() -> FavoriteMovie {
        let favoriteMovie = NSEntityDescription.insertNewObject(forEntityName: "FavoriteMovie", into: context) as! FavoriteMovie
        
        return favoriteMovie
    }
    
    func retrieveFavoriteMovies() -> [FavoriteMovie] {
        do {
            let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
    
    func favoriteMovie(for id: Int) -> FavoriteMovie? {
        do {
            let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let results = try context.fetch(fetchRequest)
            
            return results.first
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return nil
        }
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    func delete(favoriteMovie: FavoriteMovie) {
        context.delete(favoriteMovie)
        
        save()
    }
}
