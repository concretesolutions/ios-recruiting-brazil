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
        favoriteMovies.favoritedAt = Date()
      
        completion(true, favoriteMoviesList)
        save("addFavorite")
        
    }
    
    public func getAllFavorites() -> [FavoriteMovies]? {
        
        let sortByDate = NSSortDescriptor(key: "favoritedAt", ascending: false)
        let sortDescriptors = [sortByDate]
        
        
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

    public func getDisitinctYear() -> [NSDictionary]? {
        let fetchRequest = NSFetchRequest<NSDictionary> (entityName:"FavoriteMovies")
        fetchRequest.resultType = .dictionaryResultType
        
        // Optionally, to get only specific properties:
        fetchRequest.propertiesToFetch = ["year"]
        fetchRequest.returnsDistinctResults = true
        
        do {
            let records = try moc.fetch(fetchRequest)
            print(records)
        } catch {
            print("Core Data fetch failed:", error.localizedDescription)
        }
        
        return [NSDictionary]()
        
    }
    
    
    
    public func deleteFavorites(favoriteMovie: FavoriteMovies) {
        favoriteMoviesList = favoriteMoviesList.filter({ $0 != favoriteMovie })
        moc.delete(favoriteMovie)
        save("delete favoriteMovie")
    }

    
    // MARK: - private Functions
    private func save(_ msg: String) {
        do {
            try moc.save()
        }
        catch let error as NSError {
            print("An error occurred executing step: \(msg): \(error.localizedDescription)")
        }
    }
    

    public func favoriteExists(id: String) -> Bool {
        
        let request : NSFetchRequest<FavoriteMovies> = FavoriteMovies.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)

        do {
            let result = try moc.fetch(request)
            if result.isEmpty {
                return false
            }else{
                return true
            }
        }
        catch let error as NSError  {
            print("Error getting lesson: \(error.localizedDescription)")
        }
        
        return false
        
    }

    public func getFavorite(id: String) -> FavoriteMovies {
        
        let request : NSFetchRequest<FavoriteMovies> = FavoriteMovies.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id)
        var favoriteMovies = FavoriteMovies()
        do {
            let result = try moc.fetch(request)
            if !result.isEmpty {
                favoriteMovies = result.first!
            }
        }
        catch let error as NSError  {
            print("Error getting lesson: \(error.localizedDescription)")
        }
        
        return favoriteMovies
        
    }
    
}
