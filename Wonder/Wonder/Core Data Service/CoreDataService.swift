//
//  CoreDataService.swift
//  Wonder
//
//  Created by Marcelo on 09/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation
import CoreData


typealias FavoriteMoviesHandler = (Bool, [FavoriteMovies]) -> ()

class CoreDataService {
    
    private let moc : NSManagedObjectContext
    private var favoriteMoviesList = [FavoriteMovies]()  // NSMAnagedObject of core data
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // MARK: - Public Functions
    public func addFavorite(businessFavoriteMovies: BusinessFavoriteMovies, completion: FavoriteMoviesHandler) {
        
        let favoriteMovies = FavoriteMovies(context: moc)
        favoriteMovies.year = businessFavoriteMovies.year
        favoriteMovies.overview = businessFavoriteMovies.overview
        favoriteMovies.genre = businessFavoriteMovies.genre
        favoriteMovies.title = businessFavoriteMovies.title
        favoriteMovies.id = businessFavoriteMovies.id
        favoriteMovies.poster = businessFavoriteMovies.poster
      
        completion(true, favoriteMoviesList)
        save("addFavorite")
        
    }
    
    public func getAllFavorites() -> [FavoriteMovies]? {
        
        let sortByTitle = NSSortDescriptor(key: "title", ascending: true)
        let sortDescriptors = [sortByTitle]
        
        
        let request : NSFetchRequest<FavoriteMovies> = FavoriteMovies.fetchRequest()
        request.sortDescriptors = sortDescriptors
        
        do {
            favoriteMoviesList = try moc.fetch(request)
            return favoriteMoviesList
        } catch let error as NSError {
            print("Error getting students: \(error.localizedDescription)")
        }
        
        return nil
    }

    public func deleteFavorites(favoriteMovie: FavoriteMovies) {
        favoriteMoviesList = favoriteMoviesList.filter({ $0 != favoriteMovie })
        moc.delete(favoriteMovie)
        save("delete favoriteMovie")
    }

    
    // MARK: - private Functions
    private func save(_ msg: String) {
        do {
            
            print("☢️ will save (before))")
            try moc.save()
            print("☢️ saved (after))")
        }
        catch let error as NSError {
            print("☢️ error ☢️An error occurred executing step: \(msg): \(error.localizedDescription)")
        }
    }
    
    
    
    
    
}
