//
//  CoreDataManager.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 22/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    // MARK: - Movie CRUD
    
    static func createFavoriteMovie(with movie: Movie) {
        
        // Get context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // Create Entity
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteMovie", in: context) else { return }
        let newFavoriteMovie = NSManagedObject(entity: entity, insertInto: context)
        
        // Add Data to Entity
        newFavoriteMovie.setValue(movie.title, forKey: "title")
        newFavoriteMovie.setValue(movie.overview, forKey: "overview")
        newFavoriteMovie.setValue(movie.date, forKey: "date")
        newFavoriteMovie.setValue(movie.imgUrl, forKey: "imgUrl")
        newFavoriteMovie.setValue(movie.genres, forKey: "genres")
        
        if let picture = movie.image {
            let imgData = picture.jpegData(compressionQuality: 1.0)
            newFavoriteMovie.setValue(imgData, forKey: "picture")
        }
        
        // Save Data
        do {
            try context.save()
        } catch {
            print("Error saving favorite market into CoreData")
        }
    }
    
    static func getFavoriteMovies(completion: @escaping ([Movie]) -> Void = {_ in }) {
        
        // Get context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var movies: [Movie] = []
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        request.returnsObjectsAsFaults = false
        
        do {
            
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                
                guard let title = data.value(forKey: "title") as? String else { return }
                guard let imgUrl = data.value(forKey: "imgUrl") as? String else { return }
                guard let overview = data.value(forKey: "overview") as? String else { return }
                guard let date = data.value(forKey: "date") as? String else { return }
                guard let picture = data.value(forKey: "picture") as? Data else { return }
                guard let genres = data.value(forKey: "genres") as? [Int] else { return }
                
                guard let image = UIImage(data: picture) else { return }
                
                let movie = Movie(title: title, overview: overview, date: date, imgUrl: imgUrl, genres: genres, picture: image)
                movies.append(movie)
                
            }
            
            completion(movies)
            
        } catch {
            print("Failed")
        }
    }
    
    static func deleteFavoriteMovie(title: String) {
        
        // Get context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                guard let titleFetched = data.value(forKey: "title") as? String else { return }
                if titleFetched == title {
                    context.delete(data)
                }
            }
        } catch {
            print("Failed")
        }
        
        // Save Data
        do {
            try context.save()
        } catch {
            print("Error saving favorite market into CoreData")
        }
        
    }
    
}


