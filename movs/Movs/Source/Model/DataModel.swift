//
//  DataModel.swift
//  movs
//
//  Created by Lorien Moisyn on 19/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import Foundation

class DataModel {
    
    static var sharedInstance = DataModel()
    
    var movies: [Movie] = []
    var favoriteIds: Set<Int> = []
    
    func getFavoritesFromDevice() {
        guard let ids = UserDefaults.standard.object(forKey: "favoriteIds") as? [Int] else { return }
        ids.forEach{ favoriteIds.insert($0) }
//        favorites = movies.filter { favoriteIds.contains($0.id) }
//        favorites.forEach{ $0.isFavorite = true }
    }
    
    func saveFavoritesInDevice() {
        UserDefaults.standard.set(Array(favoriteIds), forKey: "favoriteIds")
    }
    
}
