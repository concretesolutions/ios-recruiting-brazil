//
//  DataManager.swift
//  movs
//
//  Created by Isaac Douglas on 23/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import CoreData

class DataManager {
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "movs")
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

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

extension DataManager {
    func save(_ movie: Movie) {
        
        let context = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: context)!
        let managed = NSManagedObject(entity: entity, insertInto: context)
        
        managed.setValue(movie.id, forKey: "id")
        managed.setValue(movie.title, forKey: "title")
        managed.setValue(movie.overview, forKey: "overview")
        managed.setValue(movie.releaseDate, forKey: "releaseDate")
        managed.setValue(movie.image?.base64EncodedString, forKey: "image")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func delete(_ movie: Movie) {
        
        let context = self.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let id = data.value(forKey: "id") as! Int
                if id == movie.id {
                    context.delete(data)
                    try context.save()
                    return
                }
            }
        } catch {
            let nserror = error as NSError
            print("Could not delete. \(nserror), \(nserror.userInfo)")
        }
    }
    
    func getMovies() -> [Movie] {
        
        let context = self.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        let sort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sort]
        request.returnsObjectsAsFaults = false
        
        var movies = [Movie]()
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                let movie = Movie()
                movie.id = data.value(forKey: "id") as! Int
                movie.title = data.value(forKey: "title") as! String
                movie.overview = data.value(forKey: "overview") as! String
                movie.releaseDate = data.value(forKey: "releaseDate") as! String
                movie.image = (data.value(forKey: "image") as? String)?.base64ToImage
                movies.append(movie)
            }
        } catch {
            let nserror = error as NSError
            print("Get movies error. \(nserror), \(nserror.userInfo)")
        }
        return movies
    }
    
    func isFavorite(movie: Movie) -> Bool {
        return self.getMovies().contains(where: { $0.id == movie.id })
    }
    
}
