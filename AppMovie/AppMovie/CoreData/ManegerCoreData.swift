//
//  ManegerCoreData.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 27/08/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ManegerCoreData {
    
    let appDelegate:AppDelegate
    let context:NSManagedObjectContext
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    //MARK: - COREDATA SAVE
    func save(_ object:NSManagedObject, successCompletion: @escaping() -> Void, failCompletion: @escaping(_ error: Error) -> Void) {
        do {
            try context.save()
            print("Successfully saved data.")
            successCompletion()
            return
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            context.delete(object)
            failCompletion(error)
        }
    }
    
    func getFavoriteMovies() -> [MovieEntity]? {
        let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        do {
            let list = try context.fetch(fetchRequest)
            return list
        } catch {
            print("error 321")
        }
        return nil
    }
    
//    func isFavorite(id: String) -> Bool {
//    let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
//    do {
//    
//    let list = try context.fetch(fetchRequest)
//        if (id == list.m)
//    return list
//    } catch {
//    print("error 321")
//    }
//    return nil
//    }
    
    //MARK - Filter the database by id
    func checkFavoriteMovie(movieId: String) -> Bool{
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        print("MovieIdCheck\(movieId)")
        let predicate = NSPredicate(format: "moveId == %@", movieId)
        
        request.predicate = predicate
        
        var movie = [MovieEntity]()
        
        do{
            movie = try context.fetch(request)
        }catch{
            print("Error fetching data from contect")
        }
        return !movie.isEmpty
    }
    
    func fetchObj(completion: (_ complete: Bool) -> ()) {
        //guard let managedContext = context else { return }
        
        let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        
        do {
            let movies = try context.fetch(fetchRequest)
            print(movies)
            print("Successfully fetched data.")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func fetch<T: NSManagedObject>(_ entity: T.Type,
                                   predicate: NSPredicate? = nil,
                                   successCompletion: @escaping(_ fetchedArray:[T]) -> Void,
                                   failCompletion: @escaping(_ error: Error) -> Void) {
        let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
        
        if predicate != nil {
            fetchRequest.predicate = predicate!
        }
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let movieEntity = try context.fetch(fetchRequest)
            print("Successfully fetched data.")
            if movieEntity.count > 0 {
                successCompletion(movieEntity)
                return
            } else {
                successCompletion([])
            }
        } catch {
            failCompletion(error)
        }
    }
    
    func delete<T: NSManagedObject>(_ entity: T.Type,
                                    predicate: NSPredicate,
                                    successCompletion: @escaping() -> Void,
                                    failCompletion: @escaping(_ error: Error) -> Void) {
        let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
        fetchRequest.predicate = predicate
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let movie = try context.fetch(fetchRequest)
            if (movie.count > 0) {
                context.delete(movie[0])
                do {
                    try context.save()
                    successCompletion()
                } catch {
                    failCompletion(error)
                }
            } else {
                failCompletion(NSError(domain: Bundle.main.bundleIdentifier ?? "com.appCompany.AppName" , code:-111, userInfo:[ NSLocalizedDescriptionKey: "No items to delete"]))
            }
        } catch {
            failCompletion(error)
        }
    }
}
