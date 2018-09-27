//
//  PersistenceService.swift
//  TheMovieDBConcrete
//
//  Created by eduardo soares neto on 26/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PersistenceService {
    
    class func saveFavoriteMovie(movie: Movie) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteMovie", in: context)
        let newFavorite = NSManagedObject(entity: entity!, insertInto: context)
        newFavorite.setValue(movie.name, forKey: "name")
        newFavorite.setValue(movie.movieDescription, forKey: "movieDescription")
        newFavorite.setValue(movie.year, forKey: "movieYear")
        var genresIDs = [Int]()
        for genre in movie.genres.genresArray {
            genresIDs.append(genre.genreId)
        }
        newFavorite.setValue(genresIDs, forKey: "genres")
        let imageData = UIImageJPEGRepresentation(movie.backgroundImage, 1)
        newFavorite.setValue(imageData, forKey: "backgroundImage")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    class func retrieveFavoriteMovies() -> Movies {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        let movies = Movies()
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let movie = Movie()
                
                if let name = data.value(forKey: "name") as? String {
                    movie.name = name
                }
                if let description = data.value(forKey: "movieDescription") as? String {
                    movie.movieDescription = description
                }
                if let imageData = data.value(forKey: "backgroundImage") as? Data {
                    if let image = UIImage(data: imageData) {
                        movie.backgroundImage = image
                    }
                }
                if let year = data.value(forKey: "movieYear") as? String {
                    movie.year = year
                }
                if let genres = data.value(forKey: "genres") as? [Int] {
                    for genre in genres {
                        let newGenre = Genre()
                        newGenre.genreId = genre
                        newGenre.name = AllGenresSingleton.allGenres.getGenreName(withId: genre)
                        movie.genres.genresArray.append(newGenre)
                    }
                }
                movies.movies.append(movie)
            }
            
        } catch {
            
            print("Failed")
        }
        return movies
    }
    
    class func removeFavorite(withName name:String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        request.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let result = try context.fetch(request)
            for data in result {
                context.delete(data as! NSManagedObject)
            }
            try context.save()
            
        } catch {
            
            print("Failed")
        }
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "favoriteChanged"), object: nil)
    }
    
    class func isFavorite(withTitle title: String) -> Bool {
        var isFavorite = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        request.predicate = NSPredicate(format: "name == %@", title)
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if let name = data.value(forKey: "name") as? String {
                    if title == name {
                        isFavorite = true
                    }
                }
            }
        } catch {
            print("Failed")
        }
        return isFavorite
    }
}
