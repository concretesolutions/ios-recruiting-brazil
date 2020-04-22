//
//  Database.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 19/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import Foundation

final class Database {
    /// A function that returns an array of generic codable object.
    private func fetchListFromUserDefaults<T:Codable>(key: String) -> [T] {
        do {
            guard let persistedObjects = UserDefaults.standard.value(forKey: key) as? Data else { return [] }
            let decodedListOfObjects = try JSONDecoder().decode([T].self, from: persistedObjects)
            return decodedListOfObjects
        } catch {
            debugPrint("An error occured when tried to get list of User Defaults.")
            return []
        }
    }
    /// A method that persists an array of generic codable object.
    private func persistListOnUserDefaults<T:Codable>(key: String, list: [T]){
        do {
            let encodedObject = try JSONEncoder().encode(list.self)
            UserDefaults.standard.set(encodedObject, forKey: key)
        } catch {
            debugPrint("An error occured when tried to persist list on User Defaults.")
        }
    }
}

// MARK: - Favorites List -
extension Database {
    /// A function that returns an array of favorites movies saved on the device.
    func getFavoritesList() -> [Movie]{
        return fetchListFromUserDefaults(key: AppConstants.PersistenceKey.favoritesMovies)
    }
    
    /// A function that returns if a movie is on the favorite list filtering by his id.
    func isFavorited(id: Int) -> Bool {
        let favoritesList = getFavoritesList()
        return favoritesList.contains(where: { $0.id == id })
    }
    
    /// A method that adds a new movie to the favorite movies list.
    func addNewFavorite(movie: Movie){
        var favoritesList = getFavoritesList()
        favoritesList.append(movie)
        persistListOnUserDefaults(key: AppConstants.PersistenceKey.favoritesMovies, list: favoritesList)
    }
    
    /// A method that deletes a favorite movie filtering by his id.
    func deleteFavorite(id: Int){
        var favoritesList = getFavoritesList()
        favoritesList.removeAll(where: { $0.id == id })
        persistListOnUserDefaults(key: AppConstants.PersistenceKey.favoritesMovies, list: favoritesList)
    }
    
    /// A method that clears the favorites movies persisted on the device.
    func clearFavoritesList(){
        let favoritesList: [Movie] = []
        persistListOnUserDefaults(key: AppConstants.PersistenceKey.favoritesMovies, list: favoritesList)
    }
}

// MARK: - Genre List -
extension Database {
    /// A function that returns a string with a description of all genres with a comma as separator.
    func getGenresListString(ids: [Int]) -> String{
        let genreList = getGenresList().filter({ ids.contains($0.id) }).compactMap({ $0.name })
        return genreList.joined(separator: ", ")
    }
    
    /// A function that returns an array of genres saved on the device.
    func getGenresList() -> [Genre]{
        return fetchListFromUserDefaults(key: AppConstants.PersistenceKey.genres)
    }
    
    /// A method that persists an array of genres.
    func setGenresList(genresList: [Genre]){
        persistListOnUserDefaults(key: AppConstants.PersistenceKey.genres, list: genresList)
    }
    
    /// A method that clears the genres persisted on the device.
    func clearGenresList(){
        let genresList: [Genre] = []
        persistListOnUserDefaults(key: AppConstants.PersistenceKey.genres, list: genresList)
    }
}
