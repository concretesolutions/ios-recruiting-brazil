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

class CoreDataHelperMock: CoreDataHelperProtocol {
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ConcreteChallenge", managedObjectModel: managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
                                        
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var context: NSManagedObjectContext = {
        let context = mockPersistantContainer.viewContext
        
        return context
    }()
    
    func newFavoriteMovie() -> FavoriteMovie {
        let favoriteMovie = NSEntityDescription.insertNewObject(forEntityName: "FavoriteMovie", into: context) as! FavoriteMovie
        
        return favoriteMovie
    }
    
    func retrieveFavoriteMovies() -> [FavoriteMovie] {
        let favoriteMovie = newFavoriteMovie()
        
        favoriteMovie.id = Int64(297761)
        favoriteMovie.title = "Suicide Squad"
        favoriteMovie.releaseDate = "2016-08-03"
        favoriteMovie.overview = "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences."
        favoriteMovie.voteAverage = 5.9
        
        save()
        
        return [favoriteMovie]
    }
    
    func favoriteMovie(for id: Int) -> FavoriteMovie? {
        if id == 297761 {
            return nil
        }
        
        return FavoriteMovie()
    }
    
    func save() {
        do {
            try context.save()
        }  catch {
            print("create fakes error \(error)")
        }
    }
    
    func delete(favoriteMovie: FavoriteMovie) {
        mockPersistantContainer.viewContext.delete(favoriteMovie)
    }
}
