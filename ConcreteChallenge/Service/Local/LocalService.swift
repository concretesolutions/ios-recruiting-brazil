//
//  LocalService.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation
import os.log

/// The singleton to save and retrieve data locally
class LocalService {
    static let instance = LocalService()
    private init(){}
    
    /// Identifier to save and retrieve favorites
    private static let favoriteIdentifier: String = "Favorites"
    
    /// System default Documents Directory
    private static let documentsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    
    /// Get a URL to a file in documentsDir
    private func getURLInDocumentDir(for file: String) -> URL {
        return URL(fileURLWithPath: LocalService.documentsDir.appendingPathComponent(file + ".json"))
    }
    
    /// Save the favorites list
    private func saveFavorites(_ favorites: [Int]) {
        
        let url = getURLInDocumentDir(for: LocalService.favoriteIdentifier)
        
        do {
            try JSONEncoder().encode(favorites).write(to: url)
            os_log("Saved favorites at @", log: Logger.appLog(), type: .info, String(describing: url))
        } catch {
            os_log("❌ - Could not save at @", log: Logger.appLog(), type: .fault, String(describing: url))
        }
    }
    
    /// Set movie as favorite
    func setFavorite(movieID: Int) {
        
        // Get the previous favorites to append if necessary
        var favoriteIDsToSave: [Int]
        if let previousFavorites = self.getFavoriteIDs() {
            favoriteIDsToSave = previousFavorites
            favoriteIDsToSave.append(movieID)
        } else {
            favoriteIDsToSave = [movieID]
        }
        
        saveFavorites(favoriteIDsToSave)
    }
    
    /// Remove movie as favorite
    func removeFavorite(movieID: Int) {
        
        // Get the previous favorites to remove the found if necessary
        let favoriteIDsToSave: [Int]
        if let previousFavorites = self.getFavoriteIDs() {
            favoriteIDsToSave = previousFavorites.filter { $0 != movieID }
            saveFavorites(favoriteIDsToSave)
        }
        // Else can't remove something nil
    }
    
    /// Get the favorite movie IDs
    func getFavoriteIDs() -> [Int]? {
        let url = getURLInDocumentDir(for: LocalService.favoriteIdentifier)
        do {
            let readData = try Data(contentsOf: url)
            let favorites = try JSONDecoder().decode([Int].self, from: readData)
            return favorites
        } catch {
            os_log("Could not read from @", log: Logger.appLog(), type: .info, String(describing: url))
        }
        return nil
    }
}
