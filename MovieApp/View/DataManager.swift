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
            let arrayMovie = results as? [MovieFavorite] ?? []
            completion(arrayMovie)
        }catch{
            print("Deu ruim")
            completion(nil)
        }
    }
    
    func saveInformation(movie: Movie, completion:(Bool) -> Void) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MovieFavorite", in: context)!
        
        if let movieFav = NSManagedObject(entity: entity, insertInto: context) as? MovieFavorite {
            
            movieFav.title = movie.title
            movieFav.url = movie.posterPath
            movieFav.year = movie.releaseDate
            movieFav.overview = movie.overview
            movieFav.id = Int64(movie.idMovie)
            movieFav.urlBackDrop = movie.backdropPath
            do {
                try context.save()
                completion(true)
            }catch{
                print("deu ruim")
                completion(false)
            }
        }
    }
    
    //precisar procurar no coredata um objeto do tipo MovieFavorite que tenha id == o moview.idMovie q tem tipo Movie
    func deletePerson(movie: Movie, completion: (Bool)-> Void) {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieFavorite")
        fetchRequest.predicate = NSPredicate(format: "id == %d", movie.idMovie)
        
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
