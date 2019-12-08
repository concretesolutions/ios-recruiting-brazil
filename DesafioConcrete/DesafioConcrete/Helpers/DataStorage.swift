//
//  DataStorage.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 06/12/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataStorage{
    
    func fetchData() -> [FavModel]{
        
        var favMovies:[FavModel] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return favMovies}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteMovies")
        
        do{
            let data = try managedContext.fetch(fetchRequest)
            
            for info in data{
                if let nome = info.value(forKey: "movieName") as? String,
                    let ano = info.value(forKey: "movieYear")as? String,
                    let descricao = info.value(forKey: "movieDescription")as? String,
                    let poster = info.value(forKey: "movieImage")as? Data{
                    
                    let fav = FavModel(movieName: nome, movieYear: ano, movieDescription: descricao, moviePoster: poster)
                    
                    favMovies.append(fav)
                }
            }
        }catch let error as NSError{
            print("error: \(error)")
        }
        
        return favMovies
    }
    
    func deleteData(fav:[FavModel]){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteMovies", in: managedContext)
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "FavoriteMovies")
        
        do{
            let data = try managedContext.fetch(fetch)
            
            for favorite in data{
                managedContext.delete(favorite)
            }
            
            for i in 0..<fav.count{
                let newData = NSManagedObject(entity: entity!, insertInto: managedContext)
                newData.setValue(fav[i].movieName, forKey: "movieName")
                newData.setValue(fav[i].movieYear, forKey: "movieYear")
                newData.setValue(fav[i].movieDescription, forKey: "movieDescription")
                newData.setValue(fav[i].moviePoster, forKey: "movieImage")
            }
            
            try! managedContext.save()
            
        } catch let err as NSError{
            print("Fail to Save LocalCaregiver in tableView!", err)
        }
 
    }
    
    func createData(fav:FavModel){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteMovies", in: managedContext)
        
        let data = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        data.setValue(fav.movieName, forKey: "movieName")
        data.setValue(fav.movieYear, forKey: "movieYear")
        data.setValue(fav.movieDescription, forKey: "movieDescription")
        data.setValue(fav.moviePoster, forKey: "movieImage")
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("error: \(error)")
        }
    }
}
