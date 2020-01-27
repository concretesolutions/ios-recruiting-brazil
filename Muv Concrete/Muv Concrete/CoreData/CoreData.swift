//
//  CoreData.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 21/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import CoreData
import UIKit

class CoreData {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveCoreData(movie: Movie) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MovieCoreData", in: managedContext)!
           
        let  movieCoreData = NSManagedObject(entity: entity, insertInto: managedContext) as? MovieCoreData
        movieCoreData?.id = movie.id
        movieCoreData?.backdropPath = movie.backdropPath
        movieCoreData?.title = movie.title
//        movieCoreData?.genreIDs = movie.genreIDs
        movieCoreData?.posterPath = movie.posterPath
        movieCoreData?.releaseDate = movie.releaseDate
        movieCoreData?.overview = movie.overview
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func getElementCoreData() -> [MovieCoreData]? {
        var moviesList: [MovieCoreData]?
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
         
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieCoreData")
         
        do {
            moviesList = try managedContext.fetch(fetchRequest) as? [MovieCoreData]
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return moviesList
    }
    
    func deleteElementCoreData(id: Int32) {
        var moviesList: [MovieCoreData]?
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieCoreData")
        do {
            moviesList = try managedContext.fetch(fetchRequest) as? [MovieCoreData]
            moviesList = moviesList?.filter ({$0.id == id})
            guard let movie = moviesList?.first else { return }
            managedContext.delete(movie)
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
}
