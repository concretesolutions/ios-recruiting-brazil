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
    
    func saveCoreData(movie: Movie) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MovieCoreData", in: managedContext)!
           
        let  movieCoreData = NSManagedObject(entity: entity, insertInto: managedContext) as? MovieCoreData
        movieCoreData?.id = movie.id
        movieCoreData?.backdropPath = movie.backdropPath
        movieCoreData?.title = movie.title
//        movieCoreData?.genreIDs = movie.genreIDs
        movieCoreData?.posterPath = movie.posterPath
        movieCoreData?.isFavorite = movie.isFavorite
        movieCoreData?.releaseDate = movie.releaseDate
        movieCoreData?.overview = movie.overview
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func getElementCoreData(id: Int32) -> [MovieCoreData]? {
        var moviesList: [MovieCoreData]?
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
         
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieCoreData")
         
        do {
            moviesList = try managedContext.fetch(fetchRequest) as? [MovieCoreData]
            
//            movieList = movieList?.filter( {$0.id == id })
//            movieDetail = (movieList?.first)!
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return moviesList
    }
}
