//
//  MovieCoreDataManager.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 16/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit
import CoreData

class FavoriteMovieCoreDataManager {
    
    static func saveFavoriteMovie(movie: Movie, completion: (_ status: SaveStatus) -> Void) {
        // Get context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // Create Entity
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteMovie", in: context) else { return }
        let newFavoriteMovie = NSManagedObject(entity: entity, insertInto: context)
        
        // Add Data to Entity
        newFavoriteMovie.setValue(movie.id, forKey: "id")
        newFavoriteMovie.setValue(movie.title, forKey: "title")
        newFavoriteMovie.setValue(movie.posterPath, forKey: "posterPath")
        newFavoriteMovie.setValue(movie.genreIds, forKey: "genreIds")
        newFavoriteMovie.setValue(movie.overview
            , forKey: "overview")
        newFavoriteMovie.setValue(movie.releaseDate, forKey: "releaseDate")
        
        // Save Data
        do {
            try context.save()
            completion(.success)
        } catch {
            print("Error saving favorite movie into CoreData")
            completion(.failed)
        }
    }
    
    static func getFavoriteMovies() {
        // Get context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "title") as! String)
            }
        } catch {
            print("Failed")
        }
    }
}

enum SaveStatus {
    case success
    case failed
}
