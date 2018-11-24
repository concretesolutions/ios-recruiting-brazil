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
    
    
    // MARK: - Properties
    static var favoriteMovies: [Movie] = []
    static var favoriteMoviesNSManagedObject: [NSManagedObject] = []
    static var datesFilter: [Date] = []
    
    static func saveFavoriteMovie(movie: Movie, completion: (_ status: RequestStatus) -> Void) {
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
    
    static func getFavoriteMovies(completion: @escaping (_ status: RequestStatus) -> Void) {
        // Get context
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                self.favoriteMoviesNSManagedObject = result as! [NSManagedObject]
                
                self.favoriteMovies = []
                for data in result as! [NSManagedObject] {
                    let id = data.value(forKey: "id") as! Int
                    let title = data.value(forKey: "title") as! String
                    let posterPath = data.value(forKey: "posterPath") as? String ?? nil
                    let genreIds = data.value(forKey: "genreIds") as! [Int]
                    let overview = data.value(forKey: "overview") as! String
                    let releaseDate = data.value(forKey: "releaseDate") as! Date
                    
                    self.favoriteMovies.append(Movie(id: id, title: title, posterPath: posterPath, genreIds: genreIds, overview: overview, releaseDate: releaseDate))
                }
                
                completion(.success)
            } catch {
                print("Failed")
                completion(.failed)
            }
        }
    }
    
    static func removeFavoriteMovie(at indexPath:IndexPath, completion: (_ status: RequestStatus) -> Void) {
        // Get context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(self.favoriteMoviesNSManagedObject[indexPath.row])
        
        // Save Data
        do {
            try context.save()
            self.favoriteMoviesNSManagedObject.remove(at: indexPath.row)
            self.favoriteMovies.remove(at: indexPath.row)
            completion(.success)
        } catch {
            print("Error saving favorite movie into CoreData")
            completion(.failed)
        }
    }
}

