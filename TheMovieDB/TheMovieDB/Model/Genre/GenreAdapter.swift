//
//  GenreAdapter.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 21/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import CoreData

public class GenreAdapter {
    static func parseGenres(_ responseGenres: [GenreResponse], completion: @escaping ([Genre]) -> Void) {
        var genres = [Genre]()
        CoreDataManager.shared.foregroundOperation { (context) in
            for response in responseGenres {
                let entity = Genre.entity()
                guard let newGenre = NSManagedObject(entity: entity,
                                                     insertInto: nil) as? Genre else { continue }
                newGenre.idGenre = "\(response.id)"
                newGenre.name = response.name
                genres.append(newGenre)
            }
            completion(genres)
        }
    }
    
    static func saveGenre(_ genre: Genre) {
        CoreDataManager.shared.foregroundOperation { (context) in
            guard let managedContext = context, let id = genre.idGenre  else { return }
            getGenre(withMovieID: id, inContext: managedContext, result: { (genreReturn) in
                guard genreReturn == nil else {
                    return }
                managedContext.insert(genre)
                do {
                    try managedContext.save()
                }catch{
                    managedContext.redo()
                }
            })
        }
    }
    
    static func updateGenre(currentGenre: Genre) {
        CoreDataManager.shared.foregroundOperation { (context) in
            guard let managedContext = context,let id = currentGenre.idGenre else { return }
            getGenre(withMovieID: id, inContext: managedContext) { (genre) in
                if (genre != nil) {
                    genre?.idGenre = currentGenre.idGenre
                    genre?.name = currentGenre.name
                    do {
                        try managedContext.save()
                    } catch{}
                }
            }
        }
    }
    
    static func getGenre(withMovieID id: String, inContext context: NSManagedObjectContext, result: @escaping (Genre?) -> Void) {
        let predicate = NSPredicate.init(format: "idGenre == %@", id)
        let request = Genre.fetchRequest()
        request.predicate = predicate
        var genre: Genre? = nil
        do {
            genre = try context.fetch(request).first as? Genre
        }catch{}
        result(genre)
    }
    
    static func getAllGenres(result: @escaping ([Genre]?) -> Void) {
        CoreDataManager.shared.foregroundOperation { (context) in
            guard let managedContext = context else { return }
            let request = Genre.fetchRequest()
            do {
                let genres = try managedContext.fetch(request) as? [Genre]
                result(genres)
            }catch {
                result(nil)
            }
        }
    }}

