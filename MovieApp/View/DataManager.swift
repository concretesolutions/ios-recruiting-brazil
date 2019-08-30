//
//  DataManager.swift
//  MovieApp
//
//  Created by Mac Pro on 28/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation
import CoreData

class DataManager: NSObject {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func loadData( completion: ([MovieFavorite]?)->Void ) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieFavorite")
        let context = persistentContainer.viewContext
        do {
            let results = try context.fetch(fetchRequest)
            var arrayMovie = results as? [MovieFavorite] ?? []
            completion(arrayMovie)
        }catch{
            print("Deu ruim")
            completion(nil)
        }
    }
    
    func saveInformation(movie: Movie, completion:(Bool) -> Void) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MovieFavorite", in: context)!
        
        let movieFav = NSManagedObject(entity: entity, insertInto: context)
        
        movieFav.setValue(movie.title, forKey: "title")
        movieFav.setValue(movie.posterPath, forKey: "url")
        movieFav.setValue(movie.releaseDate, forKey: "year")
        movieFav.setValue(movie.overview, forKey: "overview")
        movieFav.setValue(movie.idMovie, forKey: "id")
        do {
            try context.save()
            completion(true)
        }catch{
            print("deu ruim")
            completion(false)
        }
    }
    
    //precisar procurar no coredata um objeto do tipo MovieFavorite que tenha id == o moview.idMovie q tem tipo Movie
    func deletePerson(movie: Movie, completion: (Bool)-> Void) {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieFavorite")
        fetchRequest.predicate = NSPredicate(format: "id == %@", movie.idMovie)
        
        do {
            let result = try context.fetch(fetchRequest)
            let objectToDelete = result.last as? NSManagedObject
            if let object = objectToDelete {
                context.delete(object)
            }
            
            do{
                try context.save()
                completion(true)
            } catch{
                print("Deu Ruim")
                completion(false)
            }
            
            
        }catch{
            print("Deu Ruim")
            completion(false)
        }
    }
    
}














