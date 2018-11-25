//
//  CoreDataManager.swift
//  ConcreteTheMovieDB
//
//  Created by Guilherme Gatto on 22/11/18.
//  Copyright © 2018 Guilherme Gatto. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static func createData(movie: Movie){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let movieEntity = NSEntityDescription.entity(forEntityName: "MovieDB", in: managedContext)!
        
        let dbMovie = NSManagedObject(entity: movieEntity, insertInto: managedContext)
        dbMovie.setValue(movie.title, forKey: "title")
        dbMovie.setValue(movie.adult, forKey: "adult")
        dbMovie.setValue(movie.backdrop_path, forKey: "backdrop_path")
        dbMovie.setValue(movie.id, forKey: "id")
        dbMovie.setValue(movie.original_language, forKey: "original_language")
        dbMovie.setValue(movie.original_title, forKey: "original_title")
        dbMovie.setValue(movie.overview, forKey: "overview")
        dbMovie.setValue(movie.popularity, forKey: "popularity")
        dbMovie.setValue(movie.poster_path, forKey: "poster_path")
        dbMovie.setValue(movie.release_date, forKey: "release_date")
        dbMovie.setValue(movie.video, forKey: "video")
        dbMovie.setValue(movie.vote_average, forKey: "vote_average")
        dbMovie.setValue(movie.vote_count, forKey: "vote_count")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("could not save. \(error.debugDescription)")
        }
    }
    
    static func retriveData()-> [Movie]{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return []}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDB")
        var favoritesMovies: [Movie] = []
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                
                favoritesMovies.append(Movie(
                    vote_count: data.value(forKey: "vote_count") as! Int,
                    id: data.value(forKey: "id") as! Double,
                    video: data.value(forKey: "video") as! Bool ,
                    vote_average: data.value(forKey: "vote_average") as! Double,
                    title: data.value(forKey: "title") as! String ,
                    popularity: data.value(forKey: "popularity") as! Double,
                    poster_path: data.value(forKey: "poster_path") as! String,
                    original_language: data.value(forKey: "original_language") as! String,
                    original_title: data.value(forKey: "original_title") as! String,
                    genre_ids: [],
                    backdrop_path: data.value(forKey: "backdrop_path") as? String,
                    adult: data.value(forKey: "adult") as! Bool,
                    overview: data.value(forKey: "overview") as! String,
                    release_date: data.value(forKey: "release_date") as! String)
                )
            }
        } catch {
            print("failed to retrive")
        }
        
        return favoritesMovies
    }
    
    
    static func deleteData(movie: Movie){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDB")
        fetchRequest.predicate = NSPredicate(format: "title = %@", movie.title)
        
        do{
            let test = try managedContext.fetch(fetchRequest)
            let objectDelete = test[0] as! NSManagedObject
            managedContext.delete(objectDelete)
            
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("could not delete. \(error.debugDescription)")
            }
        }catch{
            print(error)
        }
    }
    
}
