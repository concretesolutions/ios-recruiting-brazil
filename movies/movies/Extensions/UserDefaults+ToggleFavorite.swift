//
//  UserDefaults+ToggleFavorite.swift
//  movies
//
//  Created by Jacqueline Alves on 04/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

extension UserDefaults {
    @objc dynamic var favorites: [Int] {
        return self.array(forKey: "favorites") as? [Int] ?? []
    }
    
    func toggleFavorite(withId id: Int) {
        if var favorites = self.array(forKey: "favorites") as? [Int] { // Check if favorites already exists on User Defaults
            if let idIndex = favorites.firstIndex(of: id) { // Check if given id is on favorites array
                favorites.remove(at: idIndex)
                UserDefaults.standard.set(favorites, forKey: "favorites")
                
            } else { // Given id is not on favorites array, so add to it
                favorites.append(id)
                UserDefaults.standard.set(favorites, forKey: "favorites")
            }
        } else { // Favorites array doesn't exists, so create it
            let favorites: [Int] = [id]
            
            UserDefaults.standard.set(favorites, forKey: "favorites") // Create array of favorites on User Defaults
        }
    }
    
    func isFavorite(_ id: Int) -> Bool {
        if let favorites = self.array(forKey: "favorites") as? [Int] {
            return favorites.contains(id)
        } else {
            return false
        }
    }
}
