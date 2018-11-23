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
    
    var appDelegate: AppDelegate?
    var context: NSManagedObjectContext?
    
    // MARK: - Movie CRUD
    
    func createFavoriteMovie(with movie: Movie) {
        
        self.getContext()
        guard let context = self.context else { return }
        
        // Create Entity
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteMovies", in: context) else { return }
        let newFavoriteMovie = NSManagedObject(entity: entity, insertInto: context)
        
        // Add Data to Entity
        newFavoriteMovie.setValue(movie.title, forKey: "title")
        newFavoriteMovie.setValue(movie.overview, forKey: "overview")
        newFavoriteMovie.setValue(movie.date, forKey: "date")
        newFavoriteMovie.setValue(movie.imgUrl, forKey: "imgUrl")
        
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
    
    func getFavoriteMovies(completion: @escaping ([Movie]) -> Void = {_ in }) {
        
        self.getContext()
        guard let context = self.context else { return }
        
        var movies: [Movie] = []
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovies")
        request.returnsObjectsAsFaults = false
        
        do {
            
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                
                guard let title = data.value(forKey: "title") as? String else { return }
                guard let imgUrl = data.value(forKey: "imgUrl") as? String else { return }
                guard let overview = data.value(forKey: "overview") as? String else { return }
                guard let date = data.value(forKey: "date") as? String else { return }
                guard let picture = data.value(forKey: "picture") as? Data else { return }
                
                guard let image = UIImage(data: picture) else { return }
                
                let movie = Movie(title: title, overview: overview, date: date, imgUrl: imgUrl, picture: image)
                movies.append(movie)
                
            }
            
            completion(movies)
            
        } catch {
            print("Failed")
        }
    }
    
    func deleteFavoriteMarket(with title: String) {
        
        self.getContext()
        guard let context = self.context else { return }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovies")
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
    
    // MARK: - Aux functions
    
    private func getContext() {
        // Get context
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.context = self.appDelegate?.persistentContainer.viewContext
    }
    
}


