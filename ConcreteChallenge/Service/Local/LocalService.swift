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
    
    /// Save the favorites list
    private func saveFavorites(_ favorites: [Movie]) {
        
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
        
        // Get the previous favorites to append if necessary
        var favoritesToSave: [Movie]
        if let previousFavorites = self.getFavorites() {
            favoritesToSave = previousFavorites
            favoritesToSave.append(movie)
        } else {
            favoritesToSave = [movie]
        }
        
        saveFavorites(favoritesToSave)
    }
    
    /// Remove movie as favorite
    func removeFavorite(movie: Movie) {
        
        // Get the previous favorites to remove the found if necessary
        let favoritesToSave: [Movie]
        if let previousFavorites = self.getFavorites() {
            favoritesToSave = previousFavorites.filter { $0.id != movie.id }
            saveFavorites(favoritesToSave)
        }
        // Else can't remove something nil
    }
    
    /// Get the favorite movie IDs
    func getFavorites() -> [Movie]? {
        let url = getURLInDocumentDir(for: LocalService.Identifier.favorites.rawValue)
        do {
            let readData = try Data(contentsOf: url)
            let favorites = try JSONDecoder().decode([Movie].self, from: readData)
            return favorites
        } catch {
            os_log("Could not read from @", log: Logger.appLog(), type: .info, String(describing: url))
        }
        return nil
    }
}
