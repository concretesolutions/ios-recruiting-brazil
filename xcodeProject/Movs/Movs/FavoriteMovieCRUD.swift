//
//  FavoriteMovieFetcher.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 11/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol FavoriteMovieUpdateListener {
    func onFavoriteMoviesInsert(_ movieObject: MovieObject)
    func onFavoriteMoviesDelete(_ movieObject: MovieObject)
}

class FavoriteMovieCRUD {
    static var managedContext: NSManagedObjectContext? = nil
    
    private static var updateListeners: Array<FavoriteMovieUpdateListener> = []
    static func registerAsListener(_ updateListener: FavoriteMovieUpdateListener) {
        self.updateListeners.append(updateListener)
    }
    
    static func fetchAll() -> [FavoriteMovie] {
        let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        do {
            if let results = try managedContext?.fetch(fetchRequest) {
                return results
            } else {
                return []
            }
        } catch let error as NSError {
            print(error)
            return []
        }
    }
    
    static func fetch(byId id: Int) -> FavoriteMovie? {
        let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        let predicate = NSPredicate(format: "attrId = \(id)")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        do {
            let results = try managedContext?.fetch(fetchRequest)
            return results?.first
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    static func add(from movieObject: MovieObject, shouldTriggerListeners: Bool = true) {
        guard let managedContext = self.managedContext, let movieEntity = NSEntityDescription.entity(forEntityName: "FavoriteMovie", in: managedContext) else { return }
        
        let favoriteMovie = FavoriteMovie(entity: movieEntity, insertInto: managedContext)
        favoriteMovie.attrId = Int32(movieObject.id)
        favoriteMovie.attrTitle = movieObject.title
        favoriteMovie.attrRelease = movieObject.release
        favoriteMovie.attrOverview = movieObject.overview
        favoriteMovie.attrPoster = movieObject.poster
        favoriteMovie.attrPosterPath = movieObject.posterPath
        favoriteMovie.createdAt = Date()
        
        if shouldTriggerListeners {
            for updateListener in updateListeners {
                updateListener.onFavoriteMoviesInsert(movieObject)
            }
        }
    }
    
    static func delete(_ movieObject: MovieObject, shouldTriggerListeners: Bool = true) {
        if let favoriteMovie = self.fetch(byId: movieObject.id) {
            self.managedContext?.delete(favoriteMovie)
            
            if shouldTriggerListeners {
                for updateListener in updateListeners {
                    updateListener.onFavoriteMoviesDelete(movieObject)
                }
            }
        }
    }
}
