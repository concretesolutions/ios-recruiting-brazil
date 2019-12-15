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
        case genreList = "GenreList"
    }
}

// MARK: - Favorite saving -
extension LocalService {
    
    /// Save the favorites list as a dictionary with the movie id as key
    private func saveFavorites(_ favorites: [Int : Movie]) {
        
        let url = getURLInDocumentDir(for: LocalService.Identifier.favorites.rawValue)
        
        do {
            try JSONEncoder().encode(favorites).write(to: url)
            os_log("💾 - Saved favorites at @", log: Logger.appLog(), type: .info, String(describing: url))
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
    
    /// Get the favorite movies dictionary
    private func getFavorites() -> [Int : Movie]? {
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
    
    /**
     Get a list of the movies favorited by the user.
     - Returns: A list of favorited movies. Might be empty.
     */
    func getFavoritesList() -> [Movie] {
        guard let favorites = getFavorites() else {
            return []
        }
        let list = Array(favorites.values)
        list.forEach{ $0.isFavorite = true }
        
        return list
    }
    
    /**
     Check multiple favorites at once, and set the `isFavorite` property accordingly.
     - Parameter movies: The movie list to be checked.
     */
    func checkFavorites(on movies: [Movie]) {
        guard let favorites = getFavorites() else {
            return
        }
        // A movie is a favorite if it's contained in the local favorites list
        // Since movies are passed by reference, it's only necessary to set here
        movies.forEach { $0.isFavorite = (favorites[$0.id] != nil) }
    }
}

// MARK: - Genre list saving -
extension LocalService {
    /// Save the genre list as a dictionary with the genre id as key
    private func saveGenreList(_ list: [Int : Genre]) {
        
        let url = getURLInDocumentDir(for: LocalService.Identifier.genreList.rawValue)
        
        do {
            try JSONEncoder().encode(list).write(to: url)
            os_log("💾 - Saved genres at @", log: Logger.appLog(), type: .info, String(describing: url))
        } catch {
            os_log("❌ - Could not save genres at @", log: Logger.appLog(), type: .fault, String(describing: url))
        }
    }
    
    private func getGenres() -> [Int : Genre]? {
        
        let url = getURLInDocumentDir(for: LocalService.Identifier.genreList.rawValue)
        do {
            let readData = try Data(contentsOf: url)
            let genreList = try JSONDecoder().decode([Int : Genre].self, from: readData)
            return genreList
        } catch {
            os_log("Could not read from @", log: Logger.appLog(), type: .info, String(describing: url))
        }
        return nil
    }
    
    /**
     Saves the genre list locally.
     - Parameter list: The `Genre` list to be saved.
     - Important: The existing list will be overriten, may there be one.
     */
    func setGenres(list: [Genre]) {
        
        var genresToSave: [Int: Genre] = [:]
        list.forEach { genresToSave[$0.id] = $0 }
        
        saveGenreList(genresToSave)
    }
    
    /**
     Get the locally stored genres.
     - Parameter genreIDs: List of genre IDs.
     - Returns: A list of the found `Genre` or `nil` if one or more genres were not found.
     - Important: If a genre is not found, it may be time to update the saved ones.
     */
    func getGenreList(from genreIDs: [Int]) -> [Genre]? {
        
        var foundGenres = [Genre]()
        guard let genreDict = getGenres() else {
            // There's no genres saved locally
            return nil
        }
        for id in genreIDs {
            guard let genre = genreDict[id] else {
                // Means it got a genre not in the list
                return nil
            }
            foundGenres.append(genre)
        }
        return foundGenres
    }
}
