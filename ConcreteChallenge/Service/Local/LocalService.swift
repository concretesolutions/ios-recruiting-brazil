//
//  LocalService.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
import os.log

/// The singleton class to save and retrieve data locally
final class LocalService {
    
    /// Singleton instance
    static let instance = LocalService()
    private init() {}
    
    /// System default Documents Directory
    private static let documentsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    
    /// Get a URL to a file in documentsDir
    private func getURLInDocumentDir(for file: String) -> URL {
        return URL(fileURLWithPath: LocalService.documentsDir.appendingPathComponent(file + ".json"))
    }
    
    /// Enumeration of the identifiers to save
    fileprivate enum Identifier: String {
        /// Identifier to save and retrieve favorites
        case favorites = "Favorites"
        /// Identifier to save and retrieve genres
        case genres = "Genres"
    }
}

// MARK: - Favorite saving -
extension LocalService {
    
    /// Save the favorites list as a dictionary with the movie id as key
    private func saveFavorites(_ favorites: [Int : Movie]) {
        
        let url = getURLInDocumentDir(for: LocalService.Identifier.favorites.rawValue)
        
        do {
            try JSONEncoder().encode(favorites).write(to: url)
            os_log("Saved favorites at @", log: Logger.appLog(), type: .info, String(describing: url))
        } catch {
            os_log("❌ - Could not save at @", log: Logger.appLog(), type: .fault, String(describing: url))
        }
    }
    
    /// Set movie as favorite
    func setFavorite(movie: Movie) {
        
        // Get the previous favorites to add if necessary
        var favoritesToSave: [Int : Movie]
        if let previousFavorites = self.getFavorites() {
            favoritesToSave = previousFavorites
            favoritesToSave[movie.id] = movie
        } else {
            favoritesToSave = [movie.id : movie]
        }
        
        saveFavorites(favoritesToSave)
    }
    
    /// Remove movie as favorite
    func removeFavorite(movie: Movie) {
        
        // Get the current favorites to remove the movie if necessary
        if var currentFavorites = self.getFavorites() {
            currentFavorites[movie.id] = nil
            saveFavorites(currentFavorites)
        }
        // Else can't remove from something nil
    }
    
    /// Get the favorite movie IDs
    func getFavorites() -> [Int : Movie]? {
        let url = getURLInDocumentDir(for: LocalService.Identifier.favorites.rawValue)
        do {
            let readData = try Data(contentsOf: url)
            let favorites = try JSONDecoder().decode([Int : Movie].self, from: readData)
            return favorites
        } catch {
            os_log("Could not read from @", log: Logger.appLog(), type: .info, String(describing: url))
        }
        return nil
    }
    
    func isMovieFavorite(_ movie: Movie) -> Bool {
        guard let favorites = getFavorites(), let _ = favorites[movie.id] else {
            return false
        }
        return true
    }
    
    func checkFavorites(on movies: [Movie]) {
        guard let favorites = getFavorites() else {
            return
        }
        // A movie is a favorite if it's contained in the local favorites list
        // Since movies are passed by reference, it's only necessary to set here
        movies.forEach { $0.isFavorite = (favorites[$0.id] != nil) }
    }
}
