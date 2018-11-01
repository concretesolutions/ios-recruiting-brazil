//
//  CoreDataWorker.swift
//  Movs
//
//  Created by Ricardo Rachaus on 27/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataWorkingLogic {
    func create(movie: Movie)
    func isFavorite(movie: Movie) -> Bool
    func fetchFavoriteMovies() -> [Movie]
    func delete(movie: Movie)
}

class CoreDataWorker: CoreDataWorkingLogic {
    var managedContext: NSManagedObjectContext?
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func create(movie: Movie) {
        guard let managedContext = managedContext else { return }
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: managedContext)!
        let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        managedObject.setValue(movie.id, forKey: "id")
        managedObject.setValue(movie.genreIds, forKey: "genreIds")
        managedObject.setValue(movie.overview, forKey: "overview")
        managedObject.setValue(movie.posterPath, forKey: "posterPath")
        managedObject.setValue(movie.releaseDate, forKey: "releaseDate")
        managedObject.setValue(movie.title, forKey: "title")
        
        do {
            try managedContext.save()
        } catch let error {
            print(error)
        }
    }
    
    // TODO: Finish fetch favorite movies
    func fetchFavoriteMovies() -> [Movie] {
        guard let managedContext = managedContext else { return [] }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        do {
            let result = try managedContext.fetch(fetchRequest)
            result.forEach { (movie) in
                print(movie as! NSManagedObject)
            }
        } catch let error {
            print(error)
        }
        return []
    }
    
    func delete(movie: Movie) {
        guard let managedContext = managedContext else { return }
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "MovieEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)
        
        do {
            let movies = try managedContext.fetch(fetchRequest)
            let movie = movies.first as! NSManagedObject
            managedContext.delete(movie)
            do {
                try managedContext.save()
            } catch let error {
                print(error)
            }
        } catch let error {
            print(error)
        }
    }
    
    func isFavorite(movie: Movie) -> Bool {
        guard let managedContext = managedContext else { return false }
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "MovieEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)
        
        do {
            let movies = try managedContext.fetch(fetchRequest)
            return movies.count > 0
        } catch let error {
            print(error)
        }
        
        return false
    }
}
