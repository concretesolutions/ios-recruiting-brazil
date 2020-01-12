//
//  File.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 12/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import Foundation

class PListFavoritesManager: FavoriteMoviesManager {
    
    private let fileManager = FileManager.default
    private let plistName = "/favorites.plist"
    private let plistPath: String
    
    var favoritesPath: String {
        return plistPath
    }
    
    init() {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        self.plistPath = documentsPath.appending(self.plistName)
        
        if !fileManager.fileExists(atPath: self.plistPath) {
            self.saveFavorites([Int]())
        }
        
    }
    
    private func saveFavorites(_ favorites: [Int]) {
        let convertedList = favorites as NSArray
        
        convertedList.write(toFile: self.plistPath, atomically: true)
    }
    
    func getAllFavorites() -> [Int] {
        
        let favorites = NSArray(contentsOfFile: self.plistPath) as? [Int]
        
        return favorites ?? [Int]()
        
    }
    
    func checkForPresence(of movie: Movie) -> Bool {
        return getAllFavorites().contains(movie.id)
    }
    
    func addFavorite(_ movie: Movie) {
        
        guard !checkForPresence(of: movie) else { return }
        
        var favorites = getAllFavorites()
        
        favorites.append(movie.id)
        
        self.saveFavorites(favorites)
        
    }
    
    func removeFavorite(_ movie: Movie) {
        
        var favorites = getAllFavorites()

        favorites.removeAll { $0 == movie.id }
        
        self.saveFavorites(favorites)
        
    }
    
}
