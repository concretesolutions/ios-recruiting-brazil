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
    
    private let plistName = "/favorites.plist"
    
    
    
    private let plistPath = ""
    
    private let fileManager = FileManager.default
    
    init() {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        self.plistPath = documentsPath.appending(self.plistName)
        
        if !fileManager.fileExists(atPath: self.plistPath) {
            
            let favorites = List() as NSArray
            
            favorites.write(toFile: self.plistPath, atomically: true)

        }
        
    }
    
    private func getAllFavotires() -> List {
        
        let favorites = NSArray(contentsOfFile: self.plistPath) as? List
        
        return favorites ?? List()
        
    }
    
    func checkForPresence(of model: Movie) -> Bool {
        
        let favorites = getAllFavotires()
        
        //return favorites.contains(model.id)
        
        return true
    }
    
    func addFavorite(_ model: Movie) {
        
    }
    
    func removeFavorite(_ model: Movie) {
        
    }
    
    
}
