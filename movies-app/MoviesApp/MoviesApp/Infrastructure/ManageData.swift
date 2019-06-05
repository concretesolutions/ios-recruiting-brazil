//
//  ManageData.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 05/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import UIKit
import CoreData

class ManageData {
    static let entityName: String = "Favorites"
    
    func createData(movie: Movie) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: ManageData.entityName, in: managedContext)!
        let storageMovie = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        if let title = movie.title {
            storageMovie.setValue(title, forKey: MoviesCoreData.title.rawValue)
        }
        
        if let image = movie.image {
            storageMovie.setValue(image, forKey: MoviesCoreData.poster.rawValue)
        }
        
        if let releaseDate = movie.releaseDate {
            storageMovie.setValue(releaseDate, forKey: MoviesCoreData.releaseDate.rawValue)
        }
        
        if let description = movie.description {
            storageMovie.setValue(description, forKey: MoviesCoreData.resume.rawValue)
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteMovieFromCoreData(movie: Movie) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ManageData.entityName)
        
        if let title = movie.title {
            print(title)
            fetchRequest.predicate = NSPredicate(format: "title = %@", title)
        }
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            let objectToDelete = test[0] as! NSManagedObject
            
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    func resetAllRecords(in entity : String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch {
            print("There was an error")
        }
    }
}
