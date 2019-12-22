//
//  CoreDataFuncs.swift
//  DesafioIos
//
//  Created by Kacio on 14/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import Foundation
import CoreData
import UIKit

let EntityName = "FavoriteMovies"
//MARK: saved Object
public func save(movie: Movie) {
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return
    }
    let managedContext =
        appDelegate.persistentContainer.viewContext
    let entity =
        NSEntityDescription.entity(forEntityName: EntityName ,
                                   in: managedContext)!
    
    let manager = NSManagedObject(entity: entity,
                                  insertInto: managedContext)
    let savedMovies = fetch()
    for movieObject in savedMovies {
        if (movieObject.value(forKey:"id") as! Int) == movie.id{
            erase(object: movieObject)
        }
    }
    manager.setValue(movie.id, forKeyPath: "id")
    manager.setValue(movie.title, forKey: "title")
    manager.setValue(movie.backdropPath, forKey: "backdropPath")
    manager.setValue(movie.genreIDS, forKey: "genreIDS")
    manager.setValue(movie.overview, forKey: "overview")
    manager.setValue(movie.releaseDate, forKey: "releaseDate")
    do {
        try managedContext.save()
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}
// MARK: Erase a Object
public func erase(object:NSManagedObject){
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return
    }
    
    let managedContext =
        appDelegate.persistentContainer.viewContext
    
    managedContext.delete(object)
    do {
        try managedContext.save()
    } catch let error as NSError{
        print("Error While Deleting Movie: \(error.userInfo)")
    }
}
// MARK: Fetch Core Data
public func fetch() -> [NSManagedObject]{
    var movies: [NSManagedObject] = []
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return []
    }
    let managedContext =
        appDelegate.persistentContainer.viewContext
    let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: EntityName)
    do {
        movies = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
    return movies
}
func movieIsfavorite(by id:Int) -> Bool{
    let movies = fetch()
    for movie in movies{
        if id == (movie.value(forKey: "id") as! Int){
            return true
        }
    }
    return false
}
func removeNSManagedObjectById(id:Int){
    if let object = getNSManagedObjectById(id: id){
        erase(object: object)
    }
}
func getNSManagedObjectById(id:Int) -> NSManagedObject?{
    let allNSManagedObjects = fetch()
    for object in allNSManagedObjects {
        if (object.value(forKey: "id") as? Int) == id{
            return object
        }
    }
    return nil
}
