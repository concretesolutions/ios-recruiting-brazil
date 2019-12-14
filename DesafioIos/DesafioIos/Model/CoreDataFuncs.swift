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

let EntityName = "MovieIds"
//MARK: saved Object
func save(id: Int) {
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return
    }
    let managedContext =
        appDelegate.persistentContainer.viewContext
    let entity =
        NSEntityDescription.entity(forEntityName: EntityName ,
                                   in: managedContext)!
    
    let movie = NSManagedObject(entity: entity,
                                insertInto: managedContext)
    if let savedMovies = fetch(){
        for movie in savedMovies {
            if (movie.value(forKey:"id") as! Int) == id{
                erase(object: movie)
            }
        }
    }
    movie.setValue(id, forKeyPath: "id")
    do {
        try managedContext.save()
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}
// MARK: Erase a Object
func erase(object:NSManagedObject){
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
func fetch() -> [NSManagedObject]?{
    var movies: [NSManagedObject] = []
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return nil
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
    guard let movies = fetch() else {
        return false
    }
    for movie in movies{
        if id == (movie.value(forKey: "id") as! Int){
            return true
        }
    }
    return false
}
func showALLMovies(){
    if let movies = fetch(){
        for movie in movies {
            print((movie.value(forKey:"id") as! Int))
        }
    }
}
