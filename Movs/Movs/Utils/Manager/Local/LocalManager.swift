//
//  LocalManager.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 14/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import CoreData
import UIKit

class LocalManager {
    
    //var movies: [NSManagedObject] = []
    
    static func save(movie: MovieDetail) {
        var movies: [NSManagedObject] = self.fetchMovies()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "MovieLocal", in: managedContext)!
        let storageMovie = NSManagedObject(entity: entity, insertInto: managedContext)
        
        storageMovie.setValue(movie.title, forKeyPath: "title")
        let year =  String(movie.release_date.prefix(4))
        storageMovie.setValue(year, forKeyPath: "year")
        storageMovie.setValue(movie.overview, forKeyPath: "overview")
        var movieGenre = ""
        if !movie.genres!.isEmpty {
            for g in movie.genres! {
                if g.name == movie.genres!.last?.name {
                    movieGenre.append(g.name!)
                }else{
                    movieGenre.append(g.name! + ", ")
                }
            }
        }
        storageMovie.setValue(movieGenre, forKeyPath: "genre")
        storageMovie.setValue(movie.id, forKey: "id")
        // IMAGE
        
        
        do {
            try managedContext.save()
            movies.append(storageMovie)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func remove(movieID: Int) {
        let movies: [NSManagedObject] = self.fetchMovies()

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        
        var removeMovie: NSManagedObject = movies.first!
        for movie in movies {
            if let movieLocalID = movie.value(forKey: "id") as? Int {
                if movieLocalID == movieID {
                    removeMovie = movie
                }
            }
        }
        managedContext.delete(removeMovie)

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func getMovies() -> [MovieDetail] {
        var movies: [NSManagedObject] = self.fetchMovies()
        
        return []
    }
    
    static func fetchMovies() -> [NSManagedObject] {
        var movies: [NSManagedObject] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieLocal")
        
        do {
            movies = try managedContext.fetch(fetchRequest)
            return movies
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
}
