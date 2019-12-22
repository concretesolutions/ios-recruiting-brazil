//
//  FavoriteModel.swift
//  iCinetop
//
//  Created by Alcides Junior on 19/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class FavoriteModel{
    let id: Int
    let genres,originalTitle,posterPath,releaseDate, overview: String
    var data: [NSManagedObject] = []
    
    init(id: Int, genres: String, originalTitle: String, posterPath: String, releaseDate: String, overview: String){
        self.id = id
        self.genres = genres
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.overview = overview
    }
    
    convenience init(){
        self.init(id: 0, genres: "", originalTitle: "", posterPath: "", releaseDate: "", overview: "")
    }
    
    func thisMovieExists(id: Int)->Bool{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return false}
        let managerContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        do{
            let request = try managerContext.fetch(fetchRequest)
            let objectToDelete = request
            if objectToDelete.first != nil{
                return true
            }else{
                return false
            }
        }catch{
            return false
        }
    }
    
    func create(completion: @escaping (Result<Bool, Error>)->Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let managerContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: managerContext) else{return}
        
        let favMovie = NSManagedObject(entity: entity, insertInto: managerContext)
        favMovie.setValue(self.id, forKey: "id")
        favMovie.setValue(self.genres, forKey: "genres")
        favMovie.setValue(self.originalTitle, forKey: "originalTitle")
        favMovie.setValue(self.posterPath, forKey: "posterPath")
        favMovie.setValue(self.releaseDate, forKey: "releaseDate")
        favMovie.setValue(self.overview, forKey: "overview")
        
        
        do{
            try managerContext.save()
            completion(.success(true))
        }catch let error as NSError{
            completion(.failure(error))
        }
    }
    
    func getAll(completion: @escaping (Result<[NSManagedObject],Error>)->Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let managerContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        do{
            let results = try managerContext.fetch(fetchRequest)
            self.data.removeAll()
            for result in results as! [NSManagedObject]{
                self.data.append(result)
            }
            completion(.success(self.data))
        }catch let error as NSError{
            completion(.failure(error))
        }
    }
    
    func delete(id: Int, completion: @escaping (Result<Bool, Error>)->Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let managerContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        
        do{
            let request = try managerContext.fetch(fetchRequest)
            let objectToDelete = request.first as! NSManagedObject
            managerContext.delete(objectToDelete)
            
            do{
                try managerContext.save()
                completion(.success(true))
            }catch{
                completion(.failure(error))
            }
        }catch{
            completion(.failure(error))
        }
        
    }
}
