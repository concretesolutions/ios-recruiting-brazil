//
//  SaveData.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 26/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Foundation

struct SaveData: Codable {
    var favoriteMovies: [Int:Movie] = [:]
    var favoriteGenres: [Int:String] = [:]
    
    
    mutating func updateSave(saveData: SaveData) {
        self.favoriteMovies = saveData.favoriteMovies
        self.favoriteGenres = saveData.favoriteGenres
    }
}
