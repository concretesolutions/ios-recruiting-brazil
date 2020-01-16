//
//  CoreDataHelper.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 15/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }

        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext

        return context
    }()
    
    static func newFavoriteMovie() -> FavoriteMovie {
            let favoriteMovie = NSEntityDescription.insertNewObject(forEntityName: "FavoriteMovie", into: context) as! FavoriteMovie

            return favoriteMovie
    }
    
    static func retrieveFavoriteMovies() -> [FavoriteMovie] {
        do {
            let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
            let results = try context.fetch(fetchRequest)

            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")

            return []
        }
    }
    
    static func favoriteMovie(for id: Int) -> FavoriteMovie? {
        do {
            let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let results = try context.fetch(fetchRequest)

            return results.first
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")

            return nil
        }
    }
    
    static func save() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(favoriteMovie: FavoriteMovie) {
        context.delete(favoriteMovie)

        save()
    }
}
