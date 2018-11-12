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
    
    // MARK: - Business Funcions
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
    
    public func getAllFavorites(filterSelection: FilterSelection) -> [FavoriteMovies]? {
        
        let sortByDate = NSSortDescriptor(key: "favoritedAt", ascending: false)
        let sortDescriptors = [sortByDate]
        
        
        let request : NSFetchRequest<FavoriteMovies> = FavoriteMovies.fetchRequest()
        request.sortDescriptors = sortDescriptors
        
        let predicatesResults = self.getPredicates(filterSelection: filterSelection)
        if predicatesResults.count > 0 {
            let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: predicatesResults)
            request.predicate = andPredicate
        }

        do {
            favoriteMoviesList = try moc.fetch(request)
            return favoriteMoviesList
        } catch let error as NSError {
            print("Error getting all favorites: \(error.localizedDescription)")
        }
        return nil
    }

    public func getDistinctYear() -> [NSDictionary]? {
        
        let sortByYear = NSSortDescriptor(key: "year", ascending: true)
        let sortDescriptors = [sortByYear]
        
        
        let request = NSFetchRequest<NSDictionary> (entityName:"FavoriteMovies")
        request.resultType = .dictionaryResultType
        
        // Optionally, to get only specific properties:
        request.propertiesToFetch = ["year"]
        request.returnsDistinctResults = true
        request.sortDescriptors = sortDescriptors
        
        do {
            let records = try moc.fetch(request)
            return records
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
            print("Error favorite exists: \(error.localizedDescription)")
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
            print("Error getting favorite: \(error.localizedDescription)")
        }
        
        return favoriteMovies
        
    }
    
    
    // MARK: - Core Data Helper
    private func save(_ msg: String) {
        do {
            try moc.save()
        }
        catch let error as NSError {
            print("An error occurred executing step: \(msg): \(error.localizedDescription)")
        }
    }
    
    // MARK: - Predicate Helper
    private func getPredicates(filterSelection: FilterSelection) -> [NSPredicate] {
    
        var predicates = [NSPredicate]()
        
        if !filterSelection.year.isEmpty {
            let yearPredicate = NSPredicate(format: "year = %@", filterSelection.year)
            predicates.append(yearPredicate)
        }
        if !filterSelection.genre.isEmpty {
            let genrePredicate = NSPredicate(format: "genre CONTAINS[cd] %@", filterSelection.genre)
            predicates.append(genrePredicate)
        }
        if !filterSelection.searchArgument.isEmpty {
            let titlePredicate = NSPredicate(format: "title CONTAINS[cd] %@", filterSelection.searchArgument)
            predicates.append(titlePredicate)
        }
    
        return predicates
    
    }
    
}
