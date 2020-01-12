//
//  File.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 12/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import Foundation

class PListFavoritesManager: FavoritesManager {
    
    typealias Model = Movie
    typealias List = [Int]
    
    private let fileManager = FileManager.default
    private let plistName = "/favorites.plist"
    private let plistPath: String
    
    init() {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        self.plistPath = documentsPath.appending(self.plistName)
        
        if !fileManager.fileExists(atPath: self.plistPath) {
            
            self.saveFavorites(List())

        }
        
    }
    
    private func saveFavorites(_ favorites: List) {
        let convertedList = favorites as NSArray
        
        convertedList.write(toFile: self.plistPath, atomically: true)
    }
    
    func getAllFavorites() -> List {
        
        let favorites = NSArray(contentsOfFile: self.plistPath) as? List
        
        return favorites ?? List()
        
    }
    
    func checkForPresence(of model: Movie) -> Bool {
        
        let favorites = getAllFavorites()
        //return favorites.contains(model.id)
        
        return true
    }
    
    func addFavorite(_ model: Movie) {
        
        guard !checkForPresence(of: model) else { return }
        
        var favorites = getAllFavorites()
        //favorites.append(movie.id)
        
        self.saveFavorites(favorites)
        
    }
    
    func removeFavorite(_ model: Movie) {
        
        var favorites = getAllFavorites()

        //favorites.removeAll { $0 == movie.id }
        
        self.saveFavorites(favorites)
        
    }
    
}
