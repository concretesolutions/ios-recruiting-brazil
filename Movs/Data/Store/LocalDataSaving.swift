//
//  LocalDataSaving.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 27/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LocalDataSaving {
    let appDelegate: AppDelegate!
    let managedContext: NSManagedObjectContext!
    
    init() {
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    //MARK: - CRUD movies
    func store(movie: MovieEntity) -> Bool {
        
        let fetchRequestMovies = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        fetchRequestMovies.predicate = NSPredicate(format: "id == %@", String(movie.id!))
        
        var result: [Any]? = nil
        do {
            result = try? managedContext.fetch(fetchRequestMovies)
        }
        
        if result != nil && result!.count == 0 {
            let favoriteMovieEntity = NSEntityDescription.entity(forEntityName: "Movies", in: managedContext)!
            let favoriteMovie = NSManagedObject(entity: favoriteMovieEntity, insertInto: managedContext)
            favoriteMovie.setValue(Int64(movie.id!), forKey: "id")
            favoriteMovie.setValue(movie.title, forKey: "title")
            favoriteMovie.setValue(movie.releaseDate, forKey: "releaseDate")
            favoriteMovie.setValue(movie.genresIds, forKey: "genreIds")
            favoriteMovie.setValue(movie.poster, forKey: "poster")
            favoriteMovie.setValue(movie.movieDescription, forKey: "movieDescription")
            
            do{
                try managedContext.save()
            } catch let error {
                return false
            }
        }
        return true
    }
    
    func retrieveAllMovies() -> [MovieEntity]? {
        let fetchRequestMovies = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        var movies: [MovieEntity] = []
        
        do {
            let result = try? managedContext.fetch(fetchRequestMovies)
            for item in result as! [NSManagedObject] {
                let movie = MovieEntity()
                movie.id = item.value(forKey: "id") as? Int
                movie.title = item.value(forKey: "title") as? String
                movie.releaseDate = item.value(forKey: "releaseDate") as? String
                movie.genresIds = item.value(forKey: "genreIds") as? [Int]
                movie.poster = item.value(forKey: "poster") as? String
                movie.movieDescription = item.value(forKey: "movieDescription") as? String
                movies.append(movie)
                
            }
        }
        return movies
    }
    
    func delete(movie movieId: Int) -> Bool {
        let fetchRequestMovies = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        fetchRequestMovies.predicate = NSPredicate(format: "id == %@", String(movieId))
        do {
            let result = try? managedContext.fetch(fetchRequestMovies)
            for item in result as! [NSManagedObject] {
                managedContext.delete(item)
            }
            try managedContext.save()
        }
        catch {
            return false
        }
        return true
    }
    
    func deleteAllMovies() -> Bool {
        let fetchRequestMovies = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        do {
            let result = try? managedContext.fetch(fetchRequestMovies)
            for item in result as! [NSManagedObject] {
                managedContext.delete(item)
            }
            try managedContext.save()
        }
        catch {
            return false
        }
        return true
    }
    
    //MARK: - CRUD posters
    func store(poster: PosterEntity) -> Bool {
        
        let fetchRequestPosters = NSFetchRequest<NSFetchRequestResult>(entityName: "Posters")
        fetchRequestPosters.predicate = NSPredicate(format: "movieId == %@", String(poster.movieId!))
        
        var result: [Any]? = nil
        do {
            result = try? managedContext.fetch(fetchRequestPosters)
        }
        
        if result != nil && result!.count == 0  {
            let posterEntity = NSEntityDescription.entity(forEntityName: "Posters", in: managedContext)!
            let image = NSManagedObject(entity: posterEntity, insertInto: managedContext)
            image.setValue(poster.movieId, forKey: "movieId")
            image.setValue(poster.poster?.jpegData(compressionQuality: 100), forKey: "poster")
            
            do{
                try managedContext.save()
            } catch {
                return false
            }
        }
        return true
    }
    
    func retrieveAllPosters() -> [PosterEntity] {
        let fetchRequestPosters = NSFetchRequest<NSFetchRequestResult>(entityName: "Posters")
        var posters: [PosterEntity] = []
        
        do {
            let result = try? managedContext.fetch(fetchRequestPosters)
            for item in result as! [NSManagedObject] {
                let poster = PosterEntity(poster: UIImage(data: item.value(forKey: "poster") as! Data)!)
                poster.movieId = item.value(forKey: "movieId") as? Int
                posters.append(poster)
            }
        }
        return posters
    }
    
    func delete(poster movieId: Int) -> Bool {
        let fetchRequestPosters = NSFetchRequest<NSFetchRequestResult>(entityName: "Posters")
        fetchRequestPosters.predicate = NSPredicate(format: "movieId == %@", String(movieId))
        do {
            let result = try? managedContext.fetch(fetchRequestPosters)
            for item in result as! [NSManagedObject] {
                managedContext.delete(item)
            }
            try managedContext.save()
        }
        catch {
            return false
        }
        return true
    }
    
    func deleteAllPosters() -> Bool {
        let fetchRequestPosters = NSFetchRequest<NSFetchRequestResult>(entityName: "Posters")
        do {
            let result = try? managedContext.fetch(fetchRequestPosters)
            for item in result as! [NSManagedObject] {
                managedContext.delete(item)
            }
            try managedContext.save()
        }
        catch {
            return false
        }
        return true
    }
    
    //MARK: - Filters
    func isFavorite(movie movieId: Int) -> Bool {
        let fetchRequestMovies = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        fetchRequestMovies.fetchLimit = 1
        fetchRequestMovies.predicate = NSPredicate(format: "id == %@", String(movieId))
        
        do {
            let result = try? managedContext.fetch(fetchRequestMovies)

            if result!.count > 0 {
                return true
            }
        }
        return false
    }
    
    var count: Int {
        let fetchRequestMovies = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        
        do {
            guard let result = try? managedContext.fetch(fetchRequestMovies)
                else {
                    return 0
            }
            return result.count
        }
    }
}
