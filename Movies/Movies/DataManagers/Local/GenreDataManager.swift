//
//  GenreDataManager.swift
//  Movies
//
//  Created by Renan Germano on 19/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit
import CoreData

class GenreDataManager {
    
    static var genresMOs: [Int:NSManagedObject] = [:]
    
    // MARK: - Aux functions
    
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Movies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private static let context = persistentContainer.viewContext
    
    private static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Genres
    
    private struct GenreModel {
        static let entityName = "GenreModel"
        static let id = "id"
        static let name = "name"
    }
    
    static func managedObject(_ genre: Genre, _ saving: Bool = true) -> NSManagedObject? {
        if let entity = NSEntityDescription.entity(forEntityName: GenreModel.entityName, in: context) {
            let object = NSManagedObject(entity: entity, insertInto: context)
            object.setValue(genre.id, forKey: GenreModel.id)
            object.setValue(genre.name, forKey: GenreModel.name)
            if saving {
                saveContext()
                genresMOs[genre.id] = object
            }
            return object
        }
        return nil
    }
    
    static func genre(_ mo: NSManagedObject) -> Genre? {
        if let id = mo.value(forKey: GenreModel.id) as? Int,
            let name = mo.value(forKey: GenreModel.name) as? String {
            return Genre(id: id, name: name)
        }
        return nil
    }
    
    static func readGenres() -> [Genre] {
        var genres: [Genre] = []
        let genresRequest = NSFetchRequest<NSFetchRequestResult>(entityName: GenreModel.entityName)
        genresRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(genresRequest)
            if let mos = result as? [NSManagedObject] {
                for mo in mos {
                    if let genre = genre(mo) {
                        genres.append(genre)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return genres
    }
    
    static func readGenreById(_ id: Int) -> Genre? {
        let genresRequest = NSFetchRequest<NSFetchRequestResult>(entityName: GenreModel.entityName)
        genresRequest.returnsObjectsAsFaults = false
        genresRequest.predicate = NSPredicate(format: "\(GenreModel.id) == %d", id)
        
        do {
            let result = try context.fetch(genresRequest)
            if let mos = result as? [NSManagedObject],
                let mo = mos.first {
                return genre(mo)
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func readGenreByIdReturninMO(_ id: Int) -> NSManagedObject? {
        let genresRequest = NSFetchRequest<NSFetchRequestResult>(entityName: GenreModel.entityName)
        genresRequest.returnsObjectsAsFaults = false
        genresRequest.predicate = NSPredicate(format: "\(GenreModel.id) == %d", id)
        
        do {
            let result = try context.fetch(genresRequest)
            if let mos = result as? [NSManagedObject],
                let mo = mos.first {
                return mo
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func readGenresByIds(_ ids: [Int]) -> [Genre] {
        var genres: [Genre] = []
        for id in ids {
            if let genre = readGenreById(id) {
                genres.append(genre)
            }
        }
        return genres
    }
    
    static func readGenresByIdsReturningMOs(_ ids: [Int]) -> [NSManagedObject] {
        var genres: [NSManagedObject] = []
        for id in ids {
            if let mo = readGenreByIdReturninMO(id) {
                genres.append(mo)
            }
        }
        return genres
    }
    
    static func updateGenre(_ genre: Genre) {
        let genresRequest = NSFetchRequest<NSFetchRequestResult>(entityName: GenreModel.entityName)
        genresRequest.returnsObjectsAsFaults = false
        genresRequest.predicate = NSPredicate(format: "\(GenreModel.id) == %d", genre.id)
        
        do {
            let result = try context.fetch(genresRequest)
            if let mos = result as? [NSManagedObject] {
                if mos.count > 0 {
                    mos.first!.setValue(genre.name, forKey: GenreModel.name)
                    saveContext()
                } else {
                    let _ = managedObject(genre)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func updateGenres(_ genres: [Genre]) {
        for genre in genres {
            updateGenre(genre)
        }
    }
    
}
