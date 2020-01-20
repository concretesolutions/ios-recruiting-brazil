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
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ConcreteChallenge")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            fatalError()
//        }

//        let persistentContainer = appDelegate.persistentContainer
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
