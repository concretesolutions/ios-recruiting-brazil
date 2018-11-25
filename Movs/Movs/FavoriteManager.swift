//
//  FavoriteManager.swift
//  Movs
//
//  Created by Julio Brazil on 24/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit
import CoreData

public class FavoriteManager {
    public static var shared = FavoriteManager()
    
    public var favorites: [Movie] {
        get{
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
            
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
            
            do {
                let movieEntities = try context.fetch(fetchRequest) as! [MovieEntity]
                return movieEntities.map({ (entity) -> Movie in
                    return Movie(fromMovie: entity)
                })
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
            // If everything else fails
            return []
        }
    }
    
    private init (){}
    
    func favoriteMovie(_ codableMovie: Movie) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, !self.existsMovie(withID: codableMovie.id) else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)!
        
        let movie = NSManagedObject(entity: entity, insertInto: context)
                
        movie.setValue(codableMovie.id, forKeyPath: "id")
        movie.setValue(codableMovie.title, forKeyPath: "title")
        movie.setValue(codableMovie.poster_path, forKeyPath: "posterPath")
        movie.setValue(codableMovie.release_date, forKeyPath: "releaseDate")
        movie.setValue(codableMovie.genre_names, forKeyPath: "genre")
        movie.setValue(codableMovie.overview, forKeyPath: "overview")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func unfavoriteMovie(withID id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let movie = self.getMovie(withID: id) else { return }
        let context = appDelegate.persistentContainer.viewContext
        context.delete(movie)
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getMovie(withID id: Int) -> MovieEntity? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "id = \(id)")
        
        do {
            return try context.fetch(fetchRequest).first as? MovieEntity
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        // If everything else fails
        return nil
    }
    
    func existsMovie(withID id: Int) -> Bool {
        return getMovie(withID: id) != nil
    }
}
