//
//  CoreDataWorker.swift
//  Movs
//
//  Created by Ricardo Rachaus on 27/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit
import CoreData

class CoreDataWorker: CoreDataWorkingLogic {
    var managedContext: NSManagedObjectContext?
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func save(movie: Movie) {
        guard let managedContext = managedContext else { return }
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: managedContext)!
        let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        let releaseDate = String(movie.releaseDate.split(separator: "-")[0])
        
        managedObject.setValue(movie.id, forKey: "id")
        managedObject.setValue(movie.genreIds, forKey: "genreIds")
        managedObject.setValue(movie.overview, forKey: "overview")
        managedObject.setValue(movie.posterPath, forKey: "posterPath")
        managedObject.setValue(releaseDate, forKey: "releaseDate")
        managedObject.setValue(movie.title, forKey: "title")
        
        do {
            try managedContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func fetchFavoriteMovies() -> [Movie] {
        guard let managedContext = managedContext else { return [] }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        do {
            let result = try managedContext.fetch(fetchRequest)
            let favorites = result.map { (movie) -> Movie in
                return Movie.movie(from: movie as! NSManagedObject)
            }
            return favorites
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
    
    func deleteAll() {
        let movies = fetchFavoriteMovies()
        movies.forEach { (movie) in
            self.delete(movie: movie)
        }
    }
    
    func favoriteMovie(movie: Movie) {
        if isFavorite(id: movie.id) {
            delete(movie: movie)
        } else {
            save(movie: movie)
        }
    }
    
    func isFavorite(id: Int) -> Bool {
        guard let managedContext = managedContext else { return false }
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "MovieEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let movies = try managedContext.fetch(fetchRequest)
            return movies.count > 0
        } catch let error {
            print(error)
        }
        
        return false
    }

    func fetchFilteredYear(_ filter: String) -> [Movie] {
        let movies = fetchFavoriteMovies()
        var result: [Movie] = []
        movies.forEach { (movie) in
            if movie.releaseDate == filter {
                result.append(movie)
            }
        }
        return result
    }
    
    func fetchFilteredGenre(_ filter: String) -> [Movie] {
        let movies = fetchFavoriteMovies()
        var result: [Movie] = []
        movies.forEach { (movie) in
            if movie.genreIds.contains(Int(filter)!) {
                result.append(movie)
            }
        }
        return result
    }
    
    func fetchMoviesFiltered(by year: String, by genre: String) -> [Movie] {
        let movies = fetchFavoriteMovies()
        var result: [Movie] = []
        movies.forEach { (movie) in
            if movie.releaseDate == year &&
               movie.genreIds.contains(Int(genre)!) {
                result.append(movie)
            }
        }
        return result
    }
    
}
