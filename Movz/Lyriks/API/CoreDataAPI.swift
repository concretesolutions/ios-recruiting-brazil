//
//  CoreDataAPI.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 02/08/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit
import CoreData

struct CoredataEntity{
    
     static let localMovie = "LocalMovie"
    
}

struct CoreDataAPI{
    static private var favorites: [LocalMovie] = []
    static func favoritesMovies() -> [Movie]{
        var result:[Movie] = []
        favorites.forEach({ (localMovie) in
            result.append(localMovie.convertToMovie())
        })
        return result
        
    }
    /**
     Populate result array with results.
     */
    static func fetch(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoredataEntity.localMovie)
        
        do {
            let localMovies = try managedContext.fetch(fetchRequest) as? [LocalMovie]
            favorites = localMovies ?? []

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    /**
     Save movie on local database
     */
    static func save(movie: Movie) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let entity =
            NSEntityDescription.entity(forEntityName: CoredataEntity.localMovie,
                                       in: managedContext)!

        
        let localMovie = LocalMovie(entity: entity, insertInto: managedContext)
       
        localMovie.id = String(movie.id)
        localMovie.genres = movie.genres
        localMovie.title = movie.title
        localMovie.vote_average = String(movie.vote_average)
        localMovie.release_data = movie.release_date
        localMovie.overview = movie.overview

        if let image = movie.image {
            if(image.save(id: String(movie.id))){
                print("Sucesso ao salvar imagem")
                
            }else{
                print("Erro ao salvar imagem")
            }
        }
        do {
            try managedContext.save()
            fetch()
            print("favorite saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    /**
        delete object from data
     */
    static func delete(id:String){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let object = favorites.first { (object) -> Bool in
            return id == object.id
        }
        guard let validateObject = object else{
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        managedContext.delete(validateObject)
        do {
            try managedContext.save()
            //could just remove element from array
            fetch()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
        
    }
    /**
     return if id is a favoritr or not
    */
    static func isFavorite(id:String)->Bool{
        return self.favorites.contains { (movie) -> Bool in
            guard let comparableId = movie.id else{
                return false
            }
            return comparableId == id
        }
    }
   
}

extension UIImage{
    /**
     Save image on celphone databaase
    */
     func save(id:String) -> Bool {
        guard let data = self.jpegData(compressionQuality: 1)
            ?? self.pngData() else {
                return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("\(id).png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    /**
     Get image from celphone databaase
     */
    static func getSavedImage(id: String) ->UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return  UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(id).path)
        }
        return nil
    }
}

